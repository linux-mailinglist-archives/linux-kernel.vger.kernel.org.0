Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE8EE6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfKDR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:58:34 -0500
Received: from mx1.cock.li ([185.10.68.5]:36239 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728392AbfKDR6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:58:33 -0500
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1572890311; bh=20O1UwoUgfY4uPo310rCxHNPlUK3x5F0/7K9qaCdM68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nQEfvGEP06nrP9k7AEpDErTnj18zH17QZzU4B//ae1SAmoCZXKZS8ZmKaklbMQO5n
         ll0dHb+WI4wkIRuP3Xck05fpvaWFiznw21TSkK0XVegLyFSFGuxk8kQGdzzghsZkwD
         44IJviXEQOVifPrK/ZnJGqMWRw4mjyNVC3F+scokgYKsRdEgfNqM8RBweCGkoeSBUz
         U5TeEBAUIBgMgqiSed3Glc3Ua54CvLO5Q7fqR2rjhVoCQNu4bFVmE6mv/VQpimrzs9
         fGYswoD3d95azWPvUh23qMkYnhlzDY3I5ofGRDN8dJcaUy1SjJpX/Sdn9I3xTgPtvX
         59cPicojy0u1Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 17:58:30 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     ruben@mrbrklyn.com, mrbrklyn@panix.com
Subject: Re: Will no-one sue GrSecurity for their blatant GPL violation (of
 GCC and the linux kernel)? - BP and EFF have addressed
In-Reply-To: <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
References: <b0668893d6fbfeca10a724e1c5846e92@firemail.cc>
 <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
Message-ID: <06a4c535e89a1485307fd7e93f18b4d3@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Perens and the EFF have addressed this, it is indeed a violation 
to add an additional restrictive term such as that: they are threatening 
a penalty, using a negative covenant, if the customer utilizes the 
permissions granted to him (and GrSecurity) by the Copyright holder of 
the original Work. GrSecurity does not have an independent legal right 
to create non-separable derivative works _at_all_, they only have 
permission to do so IF abiding by the terms the Copyright holder set 
regarding HIS Work: which are NO additional restrictive terms. Here 
GrSecurity HAS added an additional restrictive term: NO free 
redistribution of the derivative work: and they enforce this via 
penalty:

perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

Page 10 onward has discussion on the copyright issue aswell:
perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf

(And yes, IAAL)


On 2019-11-04 17:36, ams@gnu.org wrote:
> One is not under obligation to guarantee that new versions are
> distributed to someone, which also means obligations can be terminated
> for any reason.  So while grsecurity might not be doing the morally
> and ethically right thing, I do not think they are violating the GNU
> GPL.  You're still free to redistribute the patches, but grsecurity
> isn't under obligation to give you future updates.
> 
> Their agreement text is located at
> https://grsecurity.net/agree/agreement_faq
