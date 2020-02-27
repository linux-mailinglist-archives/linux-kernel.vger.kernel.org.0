Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD98B171704
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgB0MVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:21:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgB0MVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:21:49 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7IAm-0004Mu-6u; Thu, 27 Feb 2020 12:21:48 +0000
Date:   Thu, 27 Feb 2020 13:21:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 2/3] openrisc: Enable the clone3 syscall
Message-ID: <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-3-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:24AM +0900, Stafford Horne wrote:
> Enable the clone3 syscall for OpenRISC.  We use the generic version.
> 
> This was tested with the clone3 test from selftests.  Note, for all
> tests to pass it required enabling CONFIG_NAMESPACES which is not
> enabled in the default kernel config.

For OpenRISC, I assume. Hm, maybe we should fix the tests to skip when
CONFIG_NAMESPACES is not enabled.

> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
