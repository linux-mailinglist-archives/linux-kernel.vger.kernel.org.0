Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824F7136162
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgAITsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:48:19 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39754 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbgAITsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:48:16 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B7DC83AC7EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 19:15:05 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id ACE1F240005;
        Thu,  9 Jan 2020 19:15:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vasyl Gomonovych <gomonovych@gmail.com>, piotrs@cadence.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: cadence: Fix cast to pointer from integer of different size warning
Date:   Thu,  9 Jan 2020 20:15:02 +0100
Message-Id: <20200109191502.10901-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218095715.25585-1-gomonovych@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4aa906f1859614842818dc3b4cb5b27bc35961e2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-18 at 09:57:15 UTC, Vasyl Gomonovych wrote:
> Use dma_addr_t type to pass memory address and control data in
> DMA descriptor fields memory_pointer and ctrl_data_ptr
> To fix warning: cast to pointer from integer of different size
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> Acked-by: Olof Johansson <olof@lixom.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
