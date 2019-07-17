Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9376B5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGQExr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 00:53:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:38154 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGQExr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:53:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6H4rTwG008383;
        Tue, 16 Jul 2019 23:53:30 -0500
Message-ID: <f4e552a8f9959ceed4e1348b899671b5edf8c3d7.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 3/3] nvme-pci: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Wed, 17 Jul 2019 14:53:29 +1000
In-Reply-To: <20190717045000.GA4965@lst.de>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
         <20190717004527.30363-3-benh@kernel.crashing.org>
         <20190717045000.GA4965@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 06:50 +0200, Christoph Hellwig wrote:
> > # Conflicts:
> > #	drivers/nvme/host/core.c
> 
> I thought you were going to fix this up :)

Haha yeah I was ...

> But I can do that and this version of the series looks fine to me.

Thanks !

Cheers,
Ben.

