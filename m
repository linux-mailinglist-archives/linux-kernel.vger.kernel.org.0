Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162AAABBB5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfIFPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:03:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:36768 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIFPD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:03:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D1A6597D;
        Fri,  6 Sep 2019 15:03:26 +0000 (UTC)
Date:   Fri, 6 Sep 2019 09:03:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     John Garry <john.garry@huawei.com>
Cc:     <mchehab+samsung@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
Message-ID: <20190906090325.330a5945@lwn.net>
In-Reply-To: <9110efc4-35e6-ff04-1a6d-d5d9f93927de@huawei.com>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
        <20190906085212.79ec917c@lwn.net>
        <9110efc4-35e6-ff04-1a6d-d5d9f93927de@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 15:58:41 +0100
John Garry <john.garry@huawei.com> wrote:

> I don't think that it was appropriate to apply this patch in the end - 
> maybe this could have been communicated better. If you check the 
> subsequent discussion in this thread, it seems that completely new 
> documentation is required:
> 
> "Actually it seems like the whole file is obsolete and needs to be
> removed or replaced by proper documentation of the SPI MEM API."
> 
> But nothing seems to be happening there...

Ah, OK, I lost track of that somewhere along the way.

Unless you object I'll leave it applied, it's not going to do any harm,
methinks.

jon
