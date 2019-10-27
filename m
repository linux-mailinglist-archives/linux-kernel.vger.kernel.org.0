Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30DDE639B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 16:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfJ0PFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 11:05:41 -0400
Received: from verein.lst.de ([213.95.11.211]:58407 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfJ0PFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:05:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEBE768B05; Sun, 27 Oct 2019 16:05:38 +0100 (CET)
Date:   Sun, 27 Oct 2019 16:05:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 2/3] nvme: Create helper function to obtain command
 effects
Message-ID: <20191027150538.GB5843@lst.de>
References: <20191025202535.12036-1-logang@deltatee.com> <20191025202535.12036-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025202535.12036-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change in this and patch 1 look fine.  But wouldn't the changes be
a little simpler to understand if you moved this patch before the
other one instead of touching the same code multiple times?
