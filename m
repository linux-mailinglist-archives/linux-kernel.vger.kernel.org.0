Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1DD63D3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfGIVWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 17:22:08 -0400
Received: from verein.lst.de ([213.95.11.211]:45661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGIVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:22:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 878DB68B02; Tue,  9 Jul 2019 23:22:06 +0200 (CEST)
Date:   Tue, 9 Jul 2019 23:22:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2] nvme-pci: Check for null on pci_alloc_p2pmem()
Message-ID: <20190709212206.GE9518@lst.de>
References: <1562605511-6564-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562605511-6564-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.3.
