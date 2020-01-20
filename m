Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27CF142CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 15:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgATOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 09:04:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:04:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00KE46cM114806;
        Mon, 20 Jan 2020 08:04:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579529047;
        bh=+Xv3pRHSeD5+/rifxAd4m2FjGsvidIUYqZb4HrDmSXQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BA3YxcrFmBPZM1+WdJ8GlunF2BXoKDJpNoFlR5A2KP6BvwXTXIOUnrgcBMtM3dxsv
         lpNhi6mpF3EfGWJhNubzZbXBBP8puwbfj9DiCmt6PqzgFnTWo4+gciaEgwMz50ZhNQ
         5cmFRcLZ4GlXlnTlcl2vjA5pcJMwYsGYZ7FrLeMw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00KE462Q049612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jan 2020 08:04:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Jan 2020 08:04:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Jan 2020 08:04:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00KE46Yk064611;
        Mon, 20 Jan 2020 08:04:06 -0600
Date:   Mon, 20 Jan 2020 08:04:06 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Colin King <colin.king@canonical.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] usb: musb: fix spelling mistake: "periperal" ->
 "peripheral"
Message-ID: <20200120140406.GA9789@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200117093124.97965-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200117093124.97965-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 17, 2020 at 09:31:24AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Do you mind to take this directly? Here is my Acked-by:

Acked-by: Bin Liu <b-liu@ti.com>

Thanks,
-Bin.

