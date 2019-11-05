Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFFF0159
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfKEP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfKEP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:26:58 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06D92053B;
        Tue,  5 Nov 2019 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572967617;
        bh=Y49i5hhOPhJugkrF4npAozYxT0zBE624ImjMcDKVD1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2w0B03Z3nwij7CLRx7gMlKWgGttnNnXAzBn1oUwsVRmqRs4TQg78leSvtraaFWD2
         tfFJNBhLGpVenI/rE1J15IbdDe8S4SSbb+DL3dOa2WEStmckDBW0d8C40qhfyecyr5
         fp0jHKRLU61DXfZykkUwrwJebdWs8Lk7ULCmM3cE=
Date:   Wed, 6 Nov 2019 00:26:54 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Message-ID: <20191105152654.GC22559@redsun51.ssa.fujisawa.hgst.com>
References: <20191105061510.22233-1-csm10495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105061510.22233-1-csm10495@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:15:10PM -0800, Charles Machalow wrote:
> Changing nvme_passthru_cmd64 to add a field: rsvd2. This field is an explicit
> marker for the padding space added on certain platforms as a result of the
> enlargement of the result field from 32 bit to 64 bits in size.

Charles,
Could you reply with your "Signed-off-by" so I can apply this patch?
Thanks.
