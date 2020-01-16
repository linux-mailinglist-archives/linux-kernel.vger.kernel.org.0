Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A413FC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 23:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbgAPWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 17:13:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbgAPWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:13:19 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isDO6-0002K7-E6; Thu, 16 Jan 2020 23:13:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D81E4101226; Thu, 16 Jan 2020 23:13:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN method to override host bridge bus window
In-Reply-To: <PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Date:   Thu, 16 Jan 2020 23:13:13 +0100
Message-ID: <87muandp8m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas,

Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> writes:

> Add pci=nobbn kernel parameter.
>
> Override the host bridge bus resource to [bus 00-ff] when specified.

Fine, but you completely fail to explain why this is useful and why
someone would utilize this command line parameter.

Thanks,

        tglx
