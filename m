Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F123E13CF92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 23:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgAOWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 17:00:20 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43628 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579125618; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KhSz6MDjMwdC6Nwg7gqos3ZZHedUXssF2MewbU5C6XI=;
        b=otoo6KHoswaAEPcdmPJJmU6z0jgiYobmzCqoEcphC7NaPGYDKWIFpUDSSDYvCt2b29eOZH
        WBvev+9PM89kYtydp3+3UU1DHfeHwcRnsNhO8Pw7zrfCY6AEUHv2aPmiVmPg8JMXYnXylC
        tKdnva8lBON6pNwIg+U2oI7R1uWnfe8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] usb: musb: jz4740-musb driver updates
Date:   Wed, 15 Jan 2020 19:00:03 -0300
Message-Id: <20200115220008.91445-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin, Greg,

Just a small note to say that this patchset lies on top of the current
usb-testing branch, since it depends on commit edce61776c7e ("usb: musb:
Add noirq type of dma create interface").

Cheers,
-Paul


