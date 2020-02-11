Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4A159530
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgBKQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgBKQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:41:09 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC01C20848;
        Tue, 11 Feb 2020 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581439268;
        bh=c+mem6JlEnQwCKCq1zucfqpBAVjKYHCjC1bHFEPaIbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaC+Ix0sgOp3GviB8ObJiIJhHU8/QuPptSEuXrurfCNiXyNh6H8a2L0e5cvvKusT1
         Jt41IBiI8X4bT9khql6YRc4v3UC/M2qDOJF5fg1LBsSez6hYhR/ZqLKDRQIkBweYHT
         gau/T+vc6ZN3w35QQS7dx6QIkaa0MNRt9wa/6rCE=
Date:   Tue, 11 Feb 2020 08:41:08 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [PATCH 1/1] usb: Add MA USB Host driver
Message-ID: <20200211164108.GC1931506@kroah.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
> +++ b/drivers/usb/mausb_host/include/common/ma_usb.h
> @@ -0,0 +1,873 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Nice.

> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License v2. See the file COPYING in the main directory of this archive for
> + * more details.

Note, COPYING does not say what you think it says here :)

Please remove all "license boilerplate" from all of these files, with
the use of SPDX you do not need it, and, as is the case here, it can
often be wrong.

thanks,

greg k-h
