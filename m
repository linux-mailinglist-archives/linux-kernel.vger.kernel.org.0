Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9CCC0D82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 23:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfI0VpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 17:45:11 -0400
Received: from verein.lst.de ([213.95.11.211]:47913 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0VpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:45:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7069A68B05; Fri, 27 Sep 2019 23:45:08 +0200 (CEST)
Date:   Fri, 27 Sep 2019 23:45:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH v2] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190927214507.GN16819@lst.de>
References: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
