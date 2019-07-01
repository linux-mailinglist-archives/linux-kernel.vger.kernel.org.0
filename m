Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E75BB02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfGALy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 07:54:58 -0400
Received: from 8bytes.org ([81.169.241.247]:33612 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGALy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:54:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6E2E3229; Mon,  1 Jul 2019 13:54:56 +0200 (CEST)
Date:   Mon, 1 Jul 2019 13:54:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Message-ID: <20190701115454.GB8166@8bytes.org>
References: <20190612215203.12711-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612215203.12711-1-kevmitch@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, Jun 12, 2019 at 02:52:01PM -0700, Kevin Mitchell wrote:
> I have tested this series on a variety of AMD CPUs with firmware
> exhibiting the issue. I have additionally tested on platforms where the
> firmware has been fixed. I tried both with and without amd_iommu=off. I
> have also tested on older CPUs where no IOMMU is detected and even one
> where the GART driver ends up running.

Thanks for the fixes, applied them all.

