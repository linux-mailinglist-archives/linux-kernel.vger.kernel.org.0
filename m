Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21F6A015
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfGPAt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 20:49:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:36355 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbfGPAt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:49:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6G0nDbQ001859;
        Mon, 15 Jul 2019 19:49:14 -0500
Message-ID: <b4dbc5d430ee9e4975c1ec26ea964e3f09796e97.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] nvme: Pass the queue to SQ_SIZE/CQ_SIZE macros
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Date:   Tue, 16 Jul 2019 10:49:13 +1000
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 10:46 +1000, Benjamin Herrenschmidt wrote:
> # Conflicts:
> #       drivers/nvme/host/pci.c
> ---

Oops :-) You can strip that or should I resend ? I'll wait for
comments/reviews regardless.

Cheers,
Ben.

