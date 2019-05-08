Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB70417272
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEHHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 03:18:29 -0400
Received: from verein.lst.de ([213.95.11.211]:37561 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfEHHS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:18:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 518E468BFE; Wed,  8 May 2019 09:18:10 +0200 (CEST)
Date:   Wed, 8 May 2019 09:18:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] nvme-pci: mark expected switch fall-through
Message-ID: <20190508071810.GC21775@lst.de>
References: <20190507142300.GA25717@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507142300.GA25717@embeddedor>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.2.
