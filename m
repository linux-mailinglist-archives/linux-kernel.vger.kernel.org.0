Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5091CECF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 20:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfENSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 14:14:38 -0400
Received: from ms.lwn.net ([45.79.88.28]:45402 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfENSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:14:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9487F308;
        Tue, 14 May 2019 18:14:37 +0000 (UTC)
Date:   Tue, 14 May 2019 12:14:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Toralf =?UTF-8?B?RsO2cnN0ZXI=?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re:
 https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html gives
 404
Message-ID: <20190514121436.7770a83a@lwn.net>
In-Reply-To: <d200d191-258e-ba3f-1c7f-9f2e7fee5b36@gmx.de>
References: <d200d191-258e-ba3f-1c7f-9f2e7fee5b36@gmx.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 19:48:12 +0200
Toralf Förster <toralf.foerster@gmx.de> wrote:

> But this link is mentioned in dmesg of 5.1.2

It works for me.  I think you just needed to wait for the relevant commit
to make it upstream and the docs to be regenerated.

Thanks,

jon
