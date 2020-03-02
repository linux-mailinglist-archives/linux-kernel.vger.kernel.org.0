Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5317640D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCBTf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:35:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:58300 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbgCBTf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:35:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ECEE6823;
        Mon,  2 Mar 2020 19:35:55 +0000 (UTC)
Date:   Mon, 2 Mar 2020 12:35:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Convert some DT documentation files to ReST
Message-ID: <20200302123554.08ac0c34@lwn.net>
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 08:59:25 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While most of the devicetree stuff has its own format (with is now being
> converted to YAML format), some documents there are actually
> describing the DT concepts and how to contribute to it.
> 
> IMHO, those documents would fit perfectly as part of the documentation
> body, as part of the firmare documents set.
> 
> This patch series manually converts some DT documents that, on my
> opinion, would belong to it.

Did you consider putting this stuff into the firmware-guide while you were
at it?  It's not a perfect fit, I guess, but it doesn't seem too awkward
either.

It also seems like it would be good to CC the devicetree folks, or at
least the devicetree mailing list?

Thanks,

jon
