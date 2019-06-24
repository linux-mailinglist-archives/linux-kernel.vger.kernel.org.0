Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCF502B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFXHEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 03:04:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfFXHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OoUthh4K4QVJptThzzsksGKju8VbXnICnnIphBGevoY=; b=BohYL1cB9GVEVEEB/AQ+8Wjp+
        b9vzWf/zdBChO5/Yxc6ATgd75pIyE2sUBr9MEVSXGU/iabRj+A7a/YiVSO98Mhva/KDGjks8AulSq
        XyqeR6U2u1kwW76TBuewbiVFdJsBNtOgafjIeXWZEbYEG6mEyfDQkyWmtRoU8RE3FRIYHOzHuk5vf
        JRh0putoHM099rGuVjmQHkDrQ6wcOUyyFof//B/CD6vJiszBlSqCvk5ikDiHNXBHO4EmpcRrlSVAE
        YEirofTW1iSPhXf11n+fiEqcpqvkNDItmurm7DbKV7yv4/QvyVisvbi/clmel2U/YLe5Riq9USF2z
        BDkMd0B9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ1R-0007yG-74; Mon, 24 Jun 2019 07:04:13 +0000
Date:   Mon, 24 Jun 2019 00:04:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
Message-ID: <20190624070413.GA23846@infradead.org>
References: <20190623173743.24088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623173743.24088-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't we have a device tree problem here if there is a domain covering
them?  I though we should only pick up an IOMMU for a given device
if DT explicitly asked for that?
