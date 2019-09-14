Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF2B2A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfINHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 03:52:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:35650 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfINHwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:52:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E7DE02CC;
        Sat, 14 Sep 2019 07:52:04 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:52:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devices.txt: improve entry for comedi (char major 98)
Message-ID: <20190914015201.61c9ea66@lwn.net>
In-Reply-To: <20190911163941.16664-1-abbotti@mev.co.uk>
References: <20190911163941.16664-1-abbotti@mev.co.uk>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 17:39:41 +0100
Ian Abbott <abbotti@mev.co.uk> wrote:

> Describe how the comedi minor device numbers are split across comedi
> devices and comedi subdevices.
> 
> Replace the current, long dead URL with an official URL for the Comedi
> project.
> 
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

Applied, thanks.

jon
