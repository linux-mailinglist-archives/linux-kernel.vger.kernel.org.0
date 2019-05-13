Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39F1BA70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfEMPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 11:54:17 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:52802 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbfEMPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:54:17 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 274557A00F0;
        Mon, 13 May 2019 17:54:15 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] fdomain: Add ISA bus support
Date:   Mon, 13 May 2019 17:54:11 +0200
User-Agent: KMail/1.9.10
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190510212335.14728-1-linux@zary.sk> <20190510212335.14728-2-linux@zary.sk> <20190513070904.GB31342@infradead.org>
In-Reply-To: <20190513070904.GB31342@infradead.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201905131754.11791.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 May 2019 09:09:04 Christoph Hellwig wrote:
> On Fri, May 10, 2019 at 11:23:35PM +0200, Ondrej Zary wrote:
> > Add Future Domain 16xx ISA SCSI support card support.
> > 
> > Tested on IBM 92F0330 card (18C50 chip) with v1.00 BIOS.
> 
> Where did you find that thing? :)

eBay :) There are also some PCMCIA cards there.
 
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> 
> The driver looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


-- 
Ondrej Zary
