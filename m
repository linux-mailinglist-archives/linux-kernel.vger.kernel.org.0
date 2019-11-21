Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D6104FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 11:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 05:03:24 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34066 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:03:24 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 49529200A6D;
        Thu, 21 Nov 2019 10:03:23 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id CE53D200D3; Thu, 21 Nov 2019 11:03:06 +0100 (CET)
Date:   Thu, 21 Nov 2019 11:03:06 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Use dev_get_drvdata where possible
Message-ID: <20191121100306.GC129595@light.dominikbrodowski.net>
References: <20190724122308.21747-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724122308.21747-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 08:23:08PM +0800, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.

Applied to the pcmcia tree.

Thanks,
	Dominik
