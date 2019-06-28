Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96199593EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF1GA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 02:00:29 -0400
Received: from verein.lst.de ([213.95.11.210]:45236 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfF1GA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:00:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5A6E568D07; Fri, 28 Jun 2019 08:00:25 +0200 (CEST)
Date:   Fri, 28 Jun 2019 08:00:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
Message-ID: <20190628060024.GA27433@lst.de>
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-3-hch@lst.de> <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:45:38PM +0200, Marc Gonzalez wrote:
> Hello Christoph,
> 
> There are some typos in the commit message that make it harder
> (for me) to parse.

The fixes looks good to me.  Ulf, do you want me to resend?
