Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD781F55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfHEOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 10:40:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43799 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfHEOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:40:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hueAP-00089V-En; Mon, 05 Aug 2019 08:40:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hueAD-0006yY-3G; Mon, 05 Aug 2019 08:40:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20190725130113.GA12932@kroah.com>
        <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
Date:   Mon, 05 Aug 2019 09:40:21 -0500
In-Reply-To: <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm> (Jiri Kosina's
        message of "Sun, 4 Aug 2019 02:17:00 +0200 (CEST)")
Message-ID: <87blx3n0a2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hueAD-0006yY-3G;;;mid=<87blx3n0a2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/734h3jRw/GfGy5IwgZetr3oaBMoj7LHI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jiri Kosina <jikos@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 12022 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 2.00 (0.0%), parse: 0.94
        (0.0%), extract_message_metadata: 2.6 (0.0%), get_uri_detail_list:
        0.72 (0.0%), tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.03 (0.0%),
        tests_pri_-900: 0.83 (0.0%), tests_pri_-90: 28 (0.2%), check_bayes: 26
        (0.2%), b_tokenize: 5 (0.0%), b_tok_get_all: 5 (0.0%), b_comp_prob:
        1.64 (0.0%), b_tok_touch_all: 2.6 (0.0%), b_finish: 0.63 (0.0%),
        tests_pri_0: 153 (1.3%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 2.2 (0.0%), poll_dns_idle: 11812 (98.3%),
        tests_pri_10: 1.71 (0.0%), tests_pri_500: 11820 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security issues
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I skimmed this and a couple things jumped out at me.

1) PGP and S/MIME because of their use of long term keys do not provide
   forward secrecy.  Which can makes it worth while to cryptographically
   factor a key or to obtain knowledge of a private key without the key
   holders knowledge.  As the keys will be used again and again over a
   long period of time.

   More recent protocol's such as Signal's Double Ratchet Protocol
   enable forward secrecy for store and foward communications, and
   remove the problem of long term keys.

2) The existence of such a process with encrypted communications to
   ensure long term confidentiality is going to make our contact people
   the targets of people who want access to knolwedge about hardware
   bugs like meltdown, before they become public.

I am just mentioning these things in case they are not immediately
obvious to everyone else involved, so that people can be certain
they are comfortable with the tradeoffs being made.

Eric
