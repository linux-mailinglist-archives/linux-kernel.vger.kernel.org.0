Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F7171723
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgB0M05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:26:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0M05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:26:57 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7IFj-0004nc-Bx; Thu, 27 Feb 2020 12:26:55 +0000
Date:   Thu, 27 Feb 2020 13:26:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/3] OpenRISC clone3 support
Message-ID: <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:22AM +0900, Stafford Horne wrote:
> This series fixes the clone3 not implemented warnings I have been seeing
> during recent builds.  It was a simple case of implementing copy_thread_tls
> and turning on clone3 generic support.  Testing shows no issues.

This all looks good to me. Thanks for doing this. We're getting closer
and closer to having all architectures supporting clone3()!

You want me to pick this series up for 5.7 or are you going through
another tree?

Christian
