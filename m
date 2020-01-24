Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0A147942
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 09:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAXIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 03:22:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36945 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:22:15 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D460FC0010;
        Fri, 24 Jan 2020 08:22:11 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:30:35 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 3/7] dt-bindings: PCI: meson: Update PCIE bindings
 documentation
Message-ID: <20200124083035.GU1803@voidbox>
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-4-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123232943.10229-4-repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing Reviewed/Acked-by from v5.

On Fri, Jan 24, 2020 at 12:29:39AM +0100, Remi Pommarel wrote:
> Now that a new PHYs has been introduced for AXG SoC family, update
> dt bindings documentation.
> 
> Please note that this breaks backward compatibility but as not a single
> devicetree uses that yet that seems ok.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       | 22 ++++++++-----------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
