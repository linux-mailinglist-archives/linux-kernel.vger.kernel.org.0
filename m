Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6649BFAE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 21:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfHXTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 15:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfHXTDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 15:03:39 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0D620850;
        Sat, 24 Aug 2019 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566673418;
        bh=V8faoiSowxfdVDSnfuFJKqgtuKh9q9FIIhDTXCo+WOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AErla3A3rEc7cT9EqjgHaROYiQvS2t+r0MBwXldY1Pm1EJUSRLV5IVNZ4OsaP36SZ
         iDSYEcxa5CbI+aiSMGTusWCKwTWA9iI2dXcZ8ZpiGZF5X84WkOJ3rQl9+WDKsv4acY
         zQnhOcnRTu46oJjn0e6QP/czZRpDWNdr/6Z6Btes=
Date:   Sat, 24 Aug 2019 21:03:25 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ezequiel@collabora.com, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx: Add i.mx8mq nitrogen8m basic dts
 support
Message-ID: <20190824190324.GB16308@X250.getinternet.no>
References: <20190819172606.6410-1-dafna.hirschfeld@collabora.com>
 <20190819172606.6410-3-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819172606.6410-3-dafna.hirschfeld@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:26:06PM +0200, Dafna Hirschfeld wrote:
> From: Gary Bisson <gary.bisson@boundarydevices.com>
> 
> Add basic dts support for i.MX8MQ NITROGEN8M.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> [Dafna: porting vendor's code to mainline]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Applied, thanks.
