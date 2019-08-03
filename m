Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641FA80806
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfHCTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 15:21:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36670 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHCTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:21:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htzaF-0003Q6-6j; Sat, 03 Aug 2019 19:20:51 +0000
Date:   Sat, 3 Aug 2019 20:20:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, sfr@canb.auug.org.au, mpe@ellerman.id.au,
        paul.burton@mips.com, colin.king@canonical.com,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        tglx@linutronix.de, arnd@arndb.de, firoz.khan@linaro.org,
        jannh@google.com, namit@vmware.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/alpha: Remove dead code
Message-ID: <20190803192051.GC1131@ZenIV.linux.org.uk>
References: <1564859856-5916-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564859856-5916-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 12:47:36AM +0530, Souptick Joarder wrote:
> These are dead code since 2.6.11. If there is no plan to use
> it further, this can be removed forever.

What's the point in removing ifdefed-out debugging printks?
