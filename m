Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7431CC8D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJBPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 11:46:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:45600 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfJBPqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:46:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1C4A491;
        Wed,  2 Oct 2019 15:46:51 +0000 (UTC)
Date:   Wed, 2 Oct 2019 09:46:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mat King <mathewk@google.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Alexander Schremmer <alex@alexanderweb.de>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191002094650.3fc06a85@lwn.net>
In-Reply-To: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 10:09:46 -0600
Mat King <mathewk@google.com> wrote:

> I have been looking into adding Linux support for electronic privacy
> screens which is a feature on some new laptops which is built into the
> display and allows users to turn it on instead of needing to use a
> physical privacy filter. In discussions with my colleagues the idea of
> using either /sys/class/backlight or /sys/class/leds but this new
> feature does not seem to quite fit into either of those classes.

FWIW, it seems that you're not alone in this; 5.4 got some support for
such screens if I understand things correctly:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=110ea1d833ad

jon
