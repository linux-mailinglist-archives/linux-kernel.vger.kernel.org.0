Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF97DCE3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfHANy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfHANy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:54:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED99520838;
        Thu,  1 Aug 2019 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667696;
        bh=b6VWoGqdheqRkM9OnmHqVVLtc9wh2RvzqyHz1w64wq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItM6GyEuTDTexWouEuvuE6yqgoBCQNWyua7TBMBO6PF2GzVp/QJSJqbhLf1LMJBgf
         UApupRrrFtyoh4vLBmX04+Rg9Cz+IQr++Jhj/Comxf3sgZ+T4sACWMmzerV3ZeGa3t
         6N3lhwhcqAJ1l9Q2q8Ee4LATS0aeIj69ZpnOhpDk=
Date:   Thu, 1 Aug 2019 15:54:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: Revert incorrect conversion to use generic
 helper
Message-ID: <20190801135451.GA26585@kroah.com>
References: <20190801061042.GA1132@kroah.com>
 <20190801102026.27312-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801102026.27312-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:20:24AM +0100, Suzuki K Poulose wrote:
> The patch "drivers: Introduce device lookup variants by ACPI_COMPANION device"
> converted an incorrect instance in i2c driver to a new helper. Revert this
> change.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")

I'll go add this...
