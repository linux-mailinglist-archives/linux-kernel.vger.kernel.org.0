Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD941B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfFLF2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 01:28:24 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43558 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFLF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:28:24 -0400
Received: by mail-io1-f50.google.com with SMTP id k20so11910833ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 22:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0egADaKHPgxEseV+5zTmwO02LpSCL+ELQpPqc7dluDI=;
        b=DTGYZ21wKGFW8ESp2178P057vVW9OtYlyO0lh1uR+Fq4qsEofRlNXVtwAsg6xwcdVS
         73cFj+JmPdmdo6NkoJivXGqzverYG6kWj8mmnxL6q2j1gVcegLL9g+xJ8cYz3M0qX0hS
         PVGaiOBPX3ml1L9PBmOj/WaviM8GnXRPTS9H22T7Qy8lysss3HgNokx+oDnFhv9okMzY
         sXotzhgTwD5e5ignqjWDKZoL+RyMxw1+0f4lySedm7IoT52fqyEjeMje6tWbhCX4AGq8
         fWy137D9h5ipiTcXxcDeNKlri5LqmWQnioTL/fCT6ykdUMoeNFlREP51cjunTHxsF8cs
         09mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0egADaKHPgxEseV+5zTmwO02LpSCL+ELQpPqc7dluDI=;
        b=lKzazwX+dYoHqGM2Woy7txSsertm5maAm9zkpLq2qm6yGPidNTdGPQUXiu846aIgZj
         gPYnpu9+3KFdzD56l+xh09aEBdBZejeYKVSHGlaP+95Qv0+a5ui7Vwt1sRs/N9SxcPEt
         mTKcy/3nYq+ceIywC7oM421i3sBFypIo/WcZsoQ73VrKJ9xNyr67rV6DlwSBhq51wFEz
         DmDmaDXBP9fWVUQb5prWXKL+io3fAP16EjgTZSx5O+pseTGjOq7sWW+mbtYlAS8rtJp7
         wVadu6NOYR4iDSk6jMQQ+SsDClddgKWKKFFznSyb14ByWe1+BPIgXqa5H7Lb/GSmMMkm
         oUBw==
X-Gm-Message-State: APjAAAU24AOjY1fJp9WY28jzlR1bPCC6yYrZoLMy7azLReut9auSCBlI
        ehTYGWZ+HYh6xat4CSxDmQvEPP87IJe12ikgdbQgK7Bt
X-Google-Smtp-Source: APXvYqxxNRo4wxH2jLBqUQXkw6LPwhrEcORYeGAzeHIGr0Ve5O5Hwsp9J+c4ZQJjXe8Qrmd6mIi52qcnzFbtg6tvYSQ=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr6420390ioa.12.1560317302867;
 Tue, 11 Jun 2019 22:28:22 -0700 (PDT)
MIME-Version: 1.0
From:   dharmendra hans <dharamhans87@gmail.com>
Date:   Wed, 12 Jun 2019 10:58:11 +0530
Message-ID: <CACUYsyG03ysubRp7UKPEQzz3Fm9e-J_yxp4S60jZ37WwagiXxA@mail.gmail.com>
Subject: madvise() flags for not to sync dirty pages to the disk in shared mapping
To:     linux-kernel@vger.kernel.org
Cc:     dharmendra singh <dharamhans87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was searching for some  madvise() flag options which allow my
application to have choice of not syncing dirty pages created through
shared mmap() to the disk. Issue is that currently dirty pages created
by the application will be synced to the disk and there is no way
application can avoid that except MADV_REMOVE. But MADV_REMOVE punches
the hole in the file and it takes a lot of time if mapping size was
big, therefore one wants to avoid this option as it delays the further
state change in application.

So  one seems to have two issue.
1) Application is forced to wait during munmap() as dirty pages are synced.
2) if one kill the application process, it lands in process defunct
state for long time and it seems pages which were created by
application are being synced to the disk.

MADV_REMOVE seems to solve it but it is really slow due to file
truncation on mapped file.
What is desired is that application should be allowed choice of no
dirty pages sync without creating hole in the mapped file.

-Dharmendra
