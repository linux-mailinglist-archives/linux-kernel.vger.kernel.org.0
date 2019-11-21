Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29344104CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 02:34:54 -0500
Received: from verein.lst.de ([213.95.11.211]:44473 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUHey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:34:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11DF568C4E; Thu, 21 Nov 2019 08:34:51 +0100 (CET)
Date:   Thu, 21 Nov 2019 08:34:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: generic DMA bypass flag
Message-ID: <20191121073450.GC24024@lst.de>
References: <20191113133731.20870-1-hch@lst.de> <d27b7b29-df78-4904-8002-b697da5cb013@arm.com> <20191114074105.GC26546@lst.de> <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com> <20191116062258.GA8913@lst.de> <f2335431-8cd4-e1ab-013d-573d163f4067@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2335431-8cd4-e1ab-013d-573d163f4067@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, does this mean you ACK this series for the powerpc use case?

Alexey and other ppc folks: can you take a look?
