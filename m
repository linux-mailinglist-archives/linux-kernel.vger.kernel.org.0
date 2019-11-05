Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD0EFFF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbfKEOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:34:54 -0500
Received: from verein.lst.de ([213.95.11.211]:45805 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbfKEOet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE7ED68AFE; Tue,  5 Nov 2019 15:34:46 +0100 (CET)
Date:   Tue, 5 Nov 2019 15:34:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark
 rsvd
Message-ID: <20191105143446.GA9840@lst.de>
References: <20191105061510.22233-1-csm10495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105061510.22233-1-csm10495@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
