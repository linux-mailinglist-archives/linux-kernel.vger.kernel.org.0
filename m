Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADC1748CB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 19:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgB2S71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 13:59:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgB2S71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJUh2GqpXTNC2Cq0Arr6LghZS9AaJa9DrC51W6/D/bY=; b=MpnmtrMRpxh4FGvhWIIZy8sBvy
        AD+sibh1VmorY9qkg75kVPTeCJEyAyo/hHbr2OY1lKO0KKyXSmz52e4UAXeYpONSCeKuEiRG6VT4g
        xFjEhUJ6r09o4HLQwlb0B1f0a+KPmnnAv6SpFqUQF40hsh8aKd++4bDOqJAVcLw0+bUrOSrseBwER
        9MyrNprswgX75oNvH1O6vvlfyYJNcaoiZWIilJFi98epRU8phtZTxiy2BRHv8hxy69cUeuxqTK+cn
        XmTQaanIbDL+rXErQtHco4kBlBp7UC3IiMvlppgZRMMvmdzTltHcjuuZlITul9U2qA70xMkdQjup+
        zkow7mFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j87KV-0001tG-W7; Sat, 29 Feb 2020 18:59:15 +0000
Date:   Sat, 29 Feb 2020 10:59:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     masahiro31.yamada@kioxia.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Message-ID: <20200229185915.GB5698@infradead.org>
References: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't just change the existing structure, instead we'll need
a compat handler for the 32-bit x86 case.
