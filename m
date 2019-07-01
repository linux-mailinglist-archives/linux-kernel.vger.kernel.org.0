Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1349986
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfFRGzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:55:38 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F8820665;
        Tue, 18 Jun 2019 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840937;
        bh=4yU2ni5pgqRgXsFw8Zoge5yRVrNEQlv+sD3OY4wEo6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKveZUJAOzxm9DGywEBLIP0l8d41IOCBd6CKoGmwTnJLNJEj1g+gNALjWCvI/iRYr
         OCMr1WrA4dJTqwgoMBikA939CBeOJxGdb4Ssoy27Hwu1tmkUydTU3qW/3uwRkensrc
         cqKlBlwZnETzllTMxomzKP7oSsHcA8pTg8d3P2fE=
Date:   Tue, 18 Jun 2019 14:54:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: add crypto node
Message-ID: <20190618065446.GC29881@dragon>
References: <20190610152331.10057-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610152331.10057-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:23:31PM +0300, Horia Geantă wrote:
> LS1028A has a SEC v5.0 compatible security engine.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Applied, thanks.
