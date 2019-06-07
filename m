Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136C638485
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFGGlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:41:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60117 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFGGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:41:19 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id ED95020005;
        Fri,  7 Jun 2019 06:41:14 +0000 (UTC)
Message-ID: <1348e0f922462c1c39b278cdd25c1985d2870bf9.camel@hadess.net>
Subject: Re: [PATCH] staging: rtl8723bs: Fix Unneeded variable: "ret".
 Return "0"
From:   Bastien Nocera <hadess@hadess.net>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Fri, 07 Jun 2019 08:41:14 +0200
In-Reply-To: <20190607031049.GA30138@t-1000>
References: <20190607031049.GA30138@t-1000>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 20:10 -0700, Shobhit Kukreti wrote:
> coccicheck reported Unneeded variable ret at
> rtl8723bs/core/rtw_ap.c:1400.
> Function "rtw_acl_remove_sta" always returns 0. Modified return type
> of the
> function to void.
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

Looks good, thanks.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

