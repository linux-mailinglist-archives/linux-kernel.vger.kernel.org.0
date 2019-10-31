Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD35EBA30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfJaXKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 19:10:08 -0400
Received: from mx1.cock.li ([185.10.68.5]:42793 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbfJaXKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:10:08 -0400
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1572562966; bh=ZEDAU4OLNqqsQbxbWvlIESgmeMLSiwy214XPoMthBZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=Y5t65ROVAd/DtK0n0NGJ2dKwH9tvQDJxJNt3UNDbRpCPRIitQXIvh0zZgeq5NJjg+
         Vt3FJUVth4baoMTCtX0r/HbjnAL7bslwcpDRiu+egY4WkkKAYHuNKqTkCNrHEk3ir0
         6UoCg/Ct4mNsRJUx87i3AwbuHJUzp0WKU7fUmcV00CsIOQr+8Np38isF9PSJbJ6fmq
         qezkLmCzZlpObf5yQD9YhfcPwbeIAijiLrI7GanPfI7UkOvL3iujHN1CfKYYB5AnDT
         NjHrvrOnUQmJWZApB2BMoHbXXYNiDl5UzbSsLyOQn5CXarZwXBiG913hCyoU4jYNUo
         l6p+RWAKcXgzA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Oct 2019 23:02:42 +0000
From:   gameonlinux@redchan.it
To:     gnu-system-discuss@gnu.org
Cc:     bruce@perens.com, rms@gnu.org, esr@thyrsus.com,
        torvalds@linux-foundation.org, bugs@gnu.support, ams@gnu.org,
        linux-kernel@vger.kernel.org
Subject: (Censored) Why will no-one sue GrSecurity for their blatant GPL
 violation (of GCC and the linux kernel)?
Message-ID: <e3a6a2070e2182be00b9720b4a1c591f@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to send this to the list, but it was dropped as "spam", which is 
no surprise since the some want to screen communications to RMS and thus 
control him.

RMS:
Could you share your thoughts, if any, of why no one will sue GrSecurity 
("Open Source Security" (a Pennsylvania company)) for their blatant 
violation of section 6 of version 2 of the GNU General Public License?

Both regarding their GCC plugins and their Linux-Kernel patch which is a 
non-separable derivative work?

They distribute such under a no-redistribution agreement to paying 
customers (the is the only distribution they do). If the customer 
redistributes the derivative works they are punished.

That is: GrSecurity (OSS) has created a contract to /Defeat/ the GPL and 
has done so successfully so far. Very successfully. The GPL is basically 
the BSD license now, since such as been allowed to stand.

This is how businesses see the GPL. They are no longer afraid: They will 
simply do what GrSecurity has done. Something that was supposed to stay 
liberated: a security patch that helped users maintain their privacy by 
not being immediately rooted when using a linux kernel on a GNU system; 
is now non-free.

With this the GPL _fails_.

NO ONE has sued GrSecurity. Thus they are seen as "having it right" 
"correct" "we can do this".

Wouldn't the FSF have standing regarding the GCC plugins atleast?
Couldn't you all rally linux-kernel copyright holders to bring a joint 
action?

References:
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf
(Page 10 onward of this brief gives a good recitation of the facts and 
issues
