Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9810481DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfHENoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:44:08 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:33074 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbfHENoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:44:06 -0400
Received: by mail-vs1-f52.google.com with SMTP id m8so56034167vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=x7VfJVP5+ruIimo+5ByaWNiBxT5h/IzipEGHY2tidNw=;
        b=nL+3qgsu2nmgOdxpOq24hvSzyv66zwoGkvCTdNZfqvkfZOXBqKiE8JFZRxB9BmFBEl
         1TBKqPREJarfBb+W3EYQ+PPHnDQWfKeXjpj9Mg22wHrXxF0tpQPlL5Apy9pVcYBqN2aB
         3PAU8cTMwpc9Khcqn/aaMUJIuYrhrLzPmhV+Ka14iHl5dMEHpBdgTcWu8p24xQEmHRwP
         Kiew64K0Ms1xpZ+2J3h+pHscQM6VdWC4sGyBsOpts27kjLG2EMt1wYR5eBO8sajnDrc3
         fs02/9OH3zL4OeyWOPkEbjOwSlxq7GzVoVJhl/NNjH/dTB1rF8TzkpqQi1tw52fzVdOt
         5qrA==
X-Gm-Message-State: APjAAAU6cssGHllQ7nHjSQGGA+1JJ/MvrDcaFhNHf05HJcC+p8m2wP6T
        j0nnI+d4GLENhYjeUq2z8dHh7qlnjBM=
X-Google-Smtp-Source: APXvYqwR9ZG+prKLMSd2gXX0NxbseG9szAtHVYlwZU+usCunLKnpFlIYvBvwSFugSA7u1IuxtSSPVQ==
X-Received: by 2002:a67:fc50:: with SMTP id p16mr96613267vsq.79.1565012645141;
        Mon, 05 Aug 2019 06:44:05 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id s13sm16372072uaj.6.2019.08.05.06.44.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 06:44:04 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id 190so55952379vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:44:04 -0700 (PDT)
X-Received: by 2002:a67:8c84:: with SMTP id o126mr95423142vsd.122.1565012644482;
 Mon, 05 Aug 2019 06:44:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 5 Aug 2019 14:43:53 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+21M+W6B2Ab9TZeNSSCVdLcU1J1LBCHO13CR0T+e=SVOQ@mail.gmail.com>
Message-ID: <CAJX_Q+21M+W6B2Ab9TZeNSSCVdLcU1J1LBCHO13CR0T+e=SVOQ@mail.gmail.com>
Subject: Question about mfd_add_devices and platform_data
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to understand mfd_add_devices call and platform_data section.
An mfd device can have platform_data, which is kmemdup at
platform_device_add_data from platform_device_add_data call inside
mfd_add_device. And after this kmemdup the new mfd device receives the
clone memory and the pointer given to platform_device_add_data is freed.

All the drivers I read the platform_data is static, which in my view can
not be freed and kfrees says:

"Don't free memory not originally allocated by kmalloc() or you will run
into trouble."

So, my questions is : Should my driver kmalloc platform_data first and then
call mfd_add_devices ? Or it's fine to give static memory to it ?

Example driver:

drivers/mfd/vexpress-sysreg.c:

static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
.label = "sys_id",
};

static struct mfd_cell vexpress_sysreg_cells[] = {
{
.name = "syscon",
.num_resources = 1,
.resources = (struct resource []) {
DEFINE_RES_MEM(SYS_ID, 0x4),
},
.platform_data = &vexpress_sysreg_sys_id_pdata,
.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
},

For this case mfd_add_devices will free vexpress_sysreg_sys_id_pdata, but
it's static.

Thanks
Lucas
