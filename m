Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94597B0A82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfILIll convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Sep 2019 04:41:41 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:40710 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730083AbfILIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:41:41 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i8Kfb-000Nhp-8h; Thu, 12 Sep 2019 10:41:39 +0200
Received: from [213.55.221.93] (helo=[100.81.146.247])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i8Kfb-000O9y-3h; Thu, 12 Sep 2019 10:41:39 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] Staging: exfat: Avoid use of strcpy
Date:   Thu, 12 Sep 2019 10:41:37 +0200
Message-Id: <EE3E234B-BC62-4ECF-A2F5-8C0A861F8D9A@volery.com>
References: <20190912083153.GN20699@kadam>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
In-Reply-To: <20190912083153.GN20699@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 12 Sep 2019, at 10:34, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> ﻿You did it.  Well done.  :P
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks :D Had some issues with my git configuration
setting up a home workstation but now it is all fine
