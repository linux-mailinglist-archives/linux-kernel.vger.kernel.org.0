Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308FF6B5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGQEuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 00:50:03 -0400
Received: from verein.lst.de ([213.95.11.211]:47086 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQEuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:50:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 646A968B05; Wed, 17 Jul 2019 06:50:00 +0200 (CEST)
Date:   Wed, 17 Jul 2019 06:50:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH v2 3/3] nvme-pci: Add support for Apple 2018+ models
Message-ID: <20190717045000.GA4965@lst.de>
References: <20190717004527.30363-1-benh@kernel.crashing.org> <20190717004527.30363-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717004527.30363-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> # Conflicts:
> #	drivers/nvme/host/core.c

I thought you were going to fix this up :)

But I can do that and this version of the series looks fine to me.
