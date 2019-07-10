Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1864AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfGJQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 12:38:57 -0400
Received: from verein.lst.de ([213.95.11.211]:51855 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfGJQi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:38:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4BD2F227A81; Wed, 10 Jul 2019 18:38:53 +0200 (CEST)
Date:   Wed, 10 Jul 2019 18:38:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
Message-ID: <20190710163853.GB25486@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu> <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com> <20190709212904.GB9636@lst.de> <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:26:46AM +0200, Marta Rybczynska wrote:
> Christoph, why would you like to put the use_ana function in the header?
> It isn't used anywhere else outside of that file.

nvme_ctrl_use_ana has a single caller in core.c as well.
