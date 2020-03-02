Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718D91754C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 08:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCBHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 02:44:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:44:13 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8fkJ-00015A-Pr; Mon, 02 Mar 2020 07:44:11 +0000
Date:   Mon, 2 Mar 2020 08:44:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 0/3] OpenRISC clone3 support
Message-ID: <20200302074411.p56ctghzllrijrqz@wittgenstein>
References: <20200301213851.8096-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:38:48AM +0900, Stafford Horne wrote:
> This series fixes the clone3 not implemented warnings I have been seeing
> during recent builds.  It was a simple case of implementing copy_thread_tls
> and turning on clone3 generic support.  Testing shows no issues.
> 
> Changes since v1:
> 
>  - Fix some comments pointed out in reviews
>  - Add Acks to 2/3 and 3/3 from Christian Brauner

Excellent. I acked all individual patches now. But the whole series:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
