Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1231048956
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfFQQxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 12:53:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58227 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:53:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45SHNb67bfz1rXhF;
        Mon, 17 Jun 2019 18:53:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45SHNb4mhtz1qqkL;
        Mon, 17 Jun 2019 18:53:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EduzkY92MSM3; Mon, 17 Jun 2019 18:53:50 +0200 (CEST)
X-Auth-Info: YMFv82YrYRNRm64KwnvzFGkYeEExd5AQ+BFIz1DoP27GE4T0WOvh/3I1eDuV+NJX
Received: from igel.home (ppp-46-244-166-202.dynamic.mnet-online.de [46.244.166.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Jun 2019 18:53:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 260DA2C1101; Mon, 17 Jun 2019 18:53:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: fix suspend/resume when IBATs 4-7 are used
References: <4291e0dd36aafff58bec429ac5355d10206c72d6.1560751738.git.christophe.leroy@c-s.fr>
X-Yow:  Okay..  I'm going home to write the ``I HATE RUBIK's CUBE
 HANDBOOK FOR DEAD CAT LOVERS''..
Date:   Mon, 17 Jun 2019 18:53:47 +0200
In-Reply-To: <4291e0dd36aafff58bec429ac5355d10206c72d6.1560751738.git.christophe.leroy@c-s.fr>
        (Christophe Leroy's message of "Mon, 17 Jun 2019 06:10:22 +0000
        (UTC)")
Message-ID: <87y32040h0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  AS      arch/powerpc/kernel/swsusp_32.o
arch/powerpc/kernel/swsusp_32.S: Assembler messages:
arch/powerpc/kernel/swsusp_32.S:109: Error: invalid bat number
arch/powerpc/kernel/swsusp_32.S:111: Error: invalid bat number
arch/powerpc/kernel/swsusp_32.S:113: Error: invalid bat number
arch/powerpc/kernel/swsusp_32.S:115: Error: invalid bat number
arch/powerpc/kernel/swsusp_32.S:117: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:119: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:121: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:123: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:143: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:145: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:147: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:149: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:151: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:153: Error: invalid bat number                  
arch/powerpc/kernel/swsusp_32.S:155: Error: invalid bat number
arch/powerpc/kernel/swsusp_32.S:157: Error: invalid bat number
make[3]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
