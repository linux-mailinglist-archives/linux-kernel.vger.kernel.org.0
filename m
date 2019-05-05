Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1013D88
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 07:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEEFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 01:15:06 -0400
Received: from mx1.cock.li ([185.10.68.5]:56791 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfEEFPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 01:15:06 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 01:15:04 EDT
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557032809; bh=zfpi9O1/J+wQXfa7/ZEITKZBdVsIPCCVvs0i+JXK0hg=;
        h=Date:From:To:Cc:Subject:From;
        b=axPaIcd3/IV3a35DHnO9CLdyoUlY2lqmKRJwv0IoSSs8Mu54nEmolQDiijwhmyJGo
         hjufMDJy+dMUaWgQQ1mSy9OimnOHr5brsIARaKJJrDnzfmv34jtChA/ogtBaSHzuUi
         fQc81lmjVZKAJ7hpxBk8wEZpFplOeAf9LLyegNoS1KcoG6IeCLcV8ZQFaHwhTf4kYi
         hL9xazkinROdJqFBiE/MVn6coq5yqeuZ2tJVMc2AulEhKzQMlWUUt2+n3tHiiLUTki
         U4u8FkTaqg/3gF4vUC9HNLDb4s9APmlHsr3MnZ9SFF4wLv0xboXOhLSqUMe6/gvPBh
         ZHfWdgrMefIEg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 May 2019 05:06:48 +0000
From:   vsnsdualce3@redchan.it
To:     Thomas Schmitt <scdbackup@gmx.net>
Cc:     debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
        qmastery16@gmail.com, rhkramer@gmail.com,
        mailinglists@mattcrews.com, jhasler@newsguy.com,
        richard@walnut.gen.nz, curty@free.fr, jmtd@debian.org,
        mick.crane@gmail.com, tomas@tuxteam.de, steve@einval.com,
        joe@jretrading.com, rms@gnu.org, esr@thyrsus.com
Subject: Re: Can a recipients rights under GNU GPL be revoked?
Message-ID: <741a011e7ee2fdec77ddd8f187db6cc6@redchan.it>
X-Sender: vsnsdualce3@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Note the word "irrevocable". So i think GPLv3 is safe.
You think wrong.

Do you know what an illusory promise is?
We'll you're staring at one there.

No bargained-for consideration (read: payment), No enforceable contract.
And, no, "obeying the license" isn't "payment": you have to do that 
regardless: otherwise you're committing copyright infringement, which 
you have a pre-existing duty to avoid.

On 2019-01-28 16:19, Thomas Schmitt wrote:
> Hi,
> 
> Ivan Ivanov wrote:
>> Yes: The linux devs can rescind their license grant. GPLv2 is a bare
>> license and is revocable by the grantor.
> 
> Do you mean
>   https://lkml.org/lkml/2018/12/24/209
> ?
> 
> The GPL does not say that it can be rescinded at the will of the 
> grantor.
> In GPLv3 it is explicitely stated:
> --------------------------------------------------------------------
>   2. Basic Permissions.
> 
>   All rights granted under this License are granted for the term of
> copyright on the Program, and are irrevocable provided the stated
> conditions are met.  This License explicitly affirms your unlimited
> permission to run the unmodified Program.  The output from running a
> covered work is covered by this License only if the output, given its
> content, constitutes a covered work.  This License acknowledges your
> rights of fair use or other equivalent, as provided by copyright law.
> --------------------------------------------------------------------
> 
> Note the word "irrevocable". So i think GPLv3 is safe.
> 
> In GPLv2, the preamble states intentions which clearly contradict a
> reserved right to revoke the once given license. The TERMS AND 
> CONDITIONS
> paragraph 4 say that if "you" lose the license rights because of 
> violations,
> "parties who have received copies, or rights, from you under this 
> License
> will not have their licenses terminated so long as such parties remain 
> in
> full compliance".
> This expresses a clear promise not to revoke the license from well 
> behaving
> license takers.
> 
> 
> Next the article quotes a conversation with Eben Moglen, lawyer of the
> Free Software Foundation.
> The only substance i see there is a reference to the principle that 
> gifts
> can be demanded back under some circumstances. In german law it is 
> because
> of the giver becomming needy or because the receiver shows outraging
> unthankfulness (e.g. an attempt to murder the giver).
> 
> I sincerely doubt that GPL is a gift in the sense of german BGB 516 - 
> 534.
> Especially paragraph 517 says that waiving income in favor of somebody
> else is not such a gift. The large number of license takers makes the
> situation quite different from the one expected by german law.
> 
> Further a demand to return the gift because of neediness would depend
> on a binding offer from a third party to pay money if the software is
> not under GPL any more. I think not even Microsoft Inc. would make such
> an offer, nowadays.
> 
> 
> Have a nice day :)
> 
> Thomas
