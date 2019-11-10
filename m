Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EACF61F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKJAgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 19:36:25 -0500
Received: from mx1.cock.li ([185.10.68.5]:56291 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbfKJAgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 19:36:25 -0500
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOTS_OF_MONEY,NO_RECEIVED,NO_RELAYS
        shortcircuit=_SCTYPE_ autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1573346180; bh=fM76dojns24yTURF01TkoisrR0ysKJmyx7SjOvKyBJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0xl+AnU/LNwgdRHb49nbYBBfV748+VW2YcNxGW0EfrrcP0pdPgW63aLrjfZ4j/UF4
         hsUC0C5BzHipprPrwebk5CWmMPuMCbyClONpGrB92W0od1gkT2v1paCs3Ia3i/RyvB
         fthEW/+FVeZwSOuPpm6s6lBCtIIJqlOzn7Nv2pYQSVaV3EyAGSC7HresoBlfJvU+Mz
         uk6VnMoRG9tm27dAVDXIsEEm4IV661hLgG3Hu82c9Vba9EBUBTlviMB5mGJfXghE+b
         EI0lkJPjllZ0eR+tH4jQvMPxOV8qWS73OFFVfKWZGcozLKRobj8JV7uLw0Redpnlmj
         KrLUiMVHfVpOw==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 10 Nov 2019 00:36:19 +0000
From:   nipponmail@firemail.cc
To:     Dmitry Alexandrov <321942@gmail.com>
Cc:     =?UTF-8?Q?Alexandre_Fran=C3=A7ois_Garreau?= 
        <galex-713@galex-713.eu>, gnu-system-discuss@gnu.org,
        gnu-system-discuss 
        <gnu-system-discuss-bounces+nipponmail=firemail.cc@gnu.org>,
        rms@gnu.org
Subject: Re: GNU/Linux Activation Technologies - You joke, but it's a reality
 now. GrSecurity is doing JUST THAT.
In-Reply-To: <36ewiyma.321942@gmail.com>
References: <E1iTQkY-0004OJ-Q7@nvs406.mirohost.net>
 <11417260.v0MZe6fCPb@pc-713> <36ewiyma.321942@gmail.com>
Message-ID: <ac0713476c46b1ad0ac85916ed50099b@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You joke, but GrSecurity is selling licenses for it's kernel patch for 
$10,000, and does per-seat licensing. It prevents redistribution of it's 
derivative work via an "access agreement" where-in the licensee promises 
not to redistribute the derivative work, or else suffer a forfeiture of 
his remaining balance, as well as suffer a penalty of recieving no 
furthur versions (which he allready paid for).

So: yes: it is allready happening.
It's not a joke anymore.

Yet you here see this as "insane talk" and "yea they can do that, let's 
patch the /next version/ of the GPL to prevent it!"

No: they /cannot/ do that. Section 6 forbids additional restrictive 
terms, they have added an addional restrictive term (licensee shall no 
redistribute except to customers if required), and are enforcing said 
restrictive term with a negative covenant.


PLEASE Read: 
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

And Page 10 on of this brief: 
perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf
(which does discuss the copyright matter, even though the case is on 
another)


On 2019-11-09 20:27, Dmitry Alexandrov wrote:
> Alexandre François Garreau <galex-713@galex-713.eu> wrote:
>> Le samedi 9 novembre 2019, 14:25:58 CET Richard Stallman a écrit :
>>> You should install GNU/Linux Activation Technologies Client if you 
>>> are running GNU/Linux.
>>> 
>>> Most distributions are already selling licenses.
>> 
>> I guess this is a forged, illegitimate, mail as it was sent through 
>> something  dealing with PHP.
> 
> Yes, of course.  Though, would consider the fact that it originates
> from the Ukraine more suspicious, than usage of PHP mailer.
> 
>> However might someone enlight me on what “GNU/Linux Activation 
>> Technologies  Client” is and how is it supposed to be installed?  Is 
>> it a trojan?
> 
> No, itʼs a someoneʼs joke [0].  It was already advertised in a same
> manner on other gnu.org m/l a week ago or so.
> 
>> Is it free? x)
> 
> | GNU Project and Linux Foundation set the following fees:
> |
> |   - Single GNU/Linux copy license: $99
> |   - Volume license (starting from 25 copies, only for
> organizations): $49 for every machine
> |   - Key Server license: $999 and full license fee for every license 
> sold
> |
> | Key Server licenses are only sold by GNU Project and Linux 
> Foundation.
> 
> [0] https://notabug.org/GLAT/howtotell
