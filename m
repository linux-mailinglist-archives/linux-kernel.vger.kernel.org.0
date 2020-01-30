Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86ADD14DE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgA3QLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 11:11:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3QLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 933D3B12D;
        Thu, 30 Jan 2020 16:11:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200130134217.GA3713@lst.de>
Date:   Thu, 30 Jan 2020 17:11:25 +0100
Subject: Re: [PATCH] dma-contiguous: CMA: give precedence to cmdline
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>, <phil@raspberrypi.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Message-Id: <C099AC3SE9HX.1WYS04PKHJU2Q@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 30, 2020 at 2:42 PM, Christoph Hellwig wrote:
> I've picked this up for Linux 5.6, sorry for the delay.

Thanks!
