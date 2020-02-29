Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC76174A02
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgB2XME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 18:12:04 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50622 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbgB2XMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:12:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2A1B729C9F;
        Sat, 29 Feb 2020 18:11:59 -0500 (EST)
Date:   Sun, 1 Mar 2020 10:11:51 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <20200229131553.GA4985@afzalpc>
Message-ID: <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <20200229131553.GA4985@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Feb 2020, afzal mohammed wrote:

> [...] 
> Specific to m68k, following changes has been made based on m68 family
> ;) feedback,
> 

None of my comments were specific to any architecture.

Also, I am not the maintainer for the affected m68k code. Greg is.

> 3. s/pr_err/pr_debug
> 

Please just ignore my opinion on that, since it contradicts the 
maintainer's guidance/preference.
