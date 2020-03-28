Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037711962A0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 01:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgC1Aiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 20:38:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35735 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726318AbgC1Aiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:38:46 -0400
Received: (qmail 21691 invoked by uid 500); 27 Mar 2020 20:38:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2020 20:38:44 -0400
Date:   Fri, 27 Mar 2020 20:38:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Al Cooper <alcooperx@gmail.com>
cc:     linux-kernel@vger.kernel.org, <andriy.shevchenko@linux.intel.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-usb@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
In-Reply-To: <20200327204711.10614-4-alcooperx@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003272037410.20728-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Al Cooper wrote:

> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

