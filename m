Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32103D44E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfJKQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:02:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:39270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:02:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA7062E6;
        Fri, 11 Oct 2019 16:02:24 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:02:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Message-ID: <20191011100223.6f3eff7e@lwn.net>
In-Reply-To: <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <201910021000.5E421A6F8F@keescook>
        <201910101535.1804FC6@keescook>
        <20191010163905.70a4d6e1@lwn.net>
        <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 08:59:22 +0000
Dragan Cvetic <draganc@xilinx.com> wrote:

> Yes, please add the file.

OK, I've applied the patch, thanks.  I took the liberty of sticking on a
final newline while I was at it.

jon
