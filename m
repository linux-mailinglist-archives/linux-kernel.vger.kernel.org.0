Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D87103A12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfKTMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:30:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfKTMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2o7mPdCS+Xb6Wl7JScpaky+DdNM4ptr5JAEHzQqoKeg=; b=SxtfoeIz9P8+Scedov3brUbat
        Ahs5MA6CV5D02w2yWeKsxLOA/LBBOamYHKJDSU9OndlAe4CeVkJ1/xQc6RTogTKPMLqIJbi+5o6WE
        gJx+XkFINFdGrL9Aih6lclfz+ROhaJbN1PinLvyptutQYe9IlcZvWXHUtj9pq62FAc0unxErKuteS
        y6wTrmkC3SrcgDgCcTjncG2zhOorMNWH6GfdmH3GDFrHe7GYJ6EhFkFFeQSxuNnimaozKeY/MRRbj
        rV+sMU2bPlyzKaVIXv0B1VLmoAqYcATmEIxhN6ZDXkY0R34F2K74gK8/HkUIhwnrUGNCtBFRa/KOV
        lOyGhijyg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXP8E-0001cB-RU; Wed, 20 Nov 2019 12:30:50 +0000
Date:   Wed, 20 Nov 2019 04:30:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: {standard input}:211: Error: operand out of range (128 is not
 between -128 and 127)
Message-ID: <20191120123050.GQ20752@bombadil.infradead.org>
References: <201911201827.kP7wux6y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911201827.kP7wux6y%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:31:38PM +0800, kbuild test robot wrote:
> Hi Matthew,
> 
> FYI, the error/warning still remains.

That's because gcc-7.4.0 is still buggy on arc.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c74386d50fbaf4a54fd3fe560f1abc709c0cff4b
> commit: 5a74ac4c4a97bd8b7dba054304d598e2a882fea6 idr: Fix idr_get_next_ul race with idr_remove
> date:   3 weeks ago
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 7.4.0
