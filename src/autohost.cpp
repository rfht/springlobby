/* Author: Tobi Vollebregt */

#include "autohost.h"
#include "battle.h"
#include "server.h"
#include "user.h"


AutoHost::AutoHost( Battle& battle )
: m_battle(battle), m_enabled(false), m_lastActionTime(0)
{
}


void AutoHost::SetEnabled( const bool enabled )
{
  m_enabled = enabled;
}


void AutoHost::OnSaidBattle( const wxString& nick, const wxString& msg )
{
  // do nothing if autohost functionality is disabled

  if (!m_enabled)
    return;

  // protect against command spam

  time_t currentTime = time(NULL);

  if ((currentTime - m_lastActionTime) < 5)
    return;

  // check for autohost commands

  if (msg == _T("!start")) {
    StartBattle();
    m_lastActionTime = currentTime;
  }
  else if (msg == _T("!balance")) {
    m_battle.Autobalance(balance_random, false, false);
    m_lastActionTime = currentTime;
  }
  else if (msg == _T("!cbalance")) {
    m_battle.Autobalance(balance_random, true, false);
    m_lastActionTime = currentTime;
  }
  else if (msg == _T("!help")) {
    m_battle.DoAction(_T("Commands: !start !balance !cbalance !help"));
    m_lastActionTime = currentTime;
  }
}


/// Should only be called if user isn't immediately kicked (ban / rank limit)
void AutoHost::OnUserAdded( User& user )
{
  m_battle.DoAction(_T("Hi ") + user.GetNick() + _T(", this battle is in SpringLobby autohost mode. For help say !help"));
}


void AutoHost::StartBattle()
{
  // todo: the logic here is copied from BattleRoomTab::OnStart, may wish to refactor this sometime.
  // note: the strings here must remain untranslated because they're visible to everyone in the battle!

  if ( m_battle.HaveMultipleBotsInSameTeam() ) {
    m_battle.DoAction(_T("There are two or more bots on the same team.  Because bots don't know how to share, this won't work."));
    return;
  }

  m_battle.GetMe().BattleStatus().ready = true;

  if ( !m_battle.IsEveryoneReady() ) {
    m_battle.DoAction(_T("Some players are not ready yet."));
    //"Some players are not ready yet.\nRing these players?"
    //m_battle.RingNotReadyPlayers();
    return;
  }

  m_battle.DoAction(_T("Starting game."));
  m_battle.GetServer().StartHostedBattle();
}


wxString AutoHost::GetExtraCommandLineParams()
{
  if (m_enabled) {
    // -m, --minimise          Start minimised
    // -q [T], --quit=[T]      Quit immediately on game over or after T seconds
    return _T("--minimise --quit=1000000000");
  }
  else
    return wxEmptyString;
}
