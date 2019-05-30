Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538812F9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfE3JtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:49:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35411 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfE3JtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:49:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so3767074wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=EzivaMa5Pk1jCKAVWliIAnnNpYPzY+wQZvNWBP7vQJ4=;
        b=LOuzHvWVB4THCbixujM3zWIQM3H+bVEvViG61qk69LK5KuIo+YdoYxcM+9e2Q+afk1
         GtXn6X8k3c5tMxweesIEmruyb0+yUKmk6ioeetf1B5Z4glMCbAbSdlw8FKJWlGlDb+Vr
         7+i11ckpk/csH+nL4lQFWi2Z6yCljwYNHJdP0ouBlHdtcjLJkyjzDsnvj8Ox0CkTMVy5
         1F5VLNuxJzujb2xk0xpwJT5i57sjkOVP4Yy3aQZDYTmqJfU4LQgzCXoYV3Fwm2D5rEIb
         uO81tLpXbVDjl7aPjNf8axtDdFWQ7NqnHxYCHx3qivErKndDKVdoX1xLyOUbU+xTGspu
         dF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=EzivaMa5Pk1jCKAVWliIAnnNpYPzY+wQZvNWBP7vQJ4=;
        b=KKQLf9lvlZwGEX+mTl2wP7F5kHh2keODMnEZ90BHQImNyAbMtMDLi1Lw0FWdmzjHs6
         pe6iYTJ0bQ6dj6igzVHDyr5qFIg5obyESSD/Iw2P7Ah0F+WN35AgSHI9OBVxLHBebsJM
         wCZ+XbcWJ6A9e6Dk1pvm92nYWeK0L8ggQwHumTdU/gJJDcSHZTrmpcmT8uR6wbB+Og6j
         nwNOSQwrxvDNG9gspqabIgeepLK/UT0B/+9xv7PeskBrNYg+sGtMEinUqfTEtl+fs26t
         WBc4hBxvVhtnqTYfbFI50RdnasX8N7f428G9na2+/IHter4uDsBN1hpwCAz9/YLc0D+G
         V2gQ==
X-Gm-Message-State: APjAAAUM9ZXCvzB5OC8Vfo3GDO08X3lOS4HFWuzzxLmBkagE4SVVuxWb
        56AbTuaM0bkdzDTdnQ7gQDiCfpFfHg4t7A==
X-Google-Smtp-Source: APXvYqyQ806VUcuMLROSnB27UoyQ+eU32Qg9E3zNVj5efE8PvyteAxadoixJSsZv/tzpjZtUdT4n3Q==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr1958122wro.253.1559209746754;
        Thu, 30 May 2019 02:49:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o4sm2246671wmo.20.2019.05.30.02.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:49:06 -0700 (PDT)
Message-ID: <5cefa712.1c69fb81.8be60.b3f9@mx.google.com>
Date:   Thu, 30 May 2019 02:49:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Kernel: v5.0.19-347-g79c6130942fe
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/346] 5.0.20-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-5.0.y boot: 124 boots: 0 failed, 124 passed (v5.0.19-347-g7=
9c6130942fe)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.19-347-g79c6130942fe/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.19-347-g79c6130942fe/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.19-347-g79c6130942fe
Git Commit: 79c6130942fe2bc8d8cc92c526e93cce6a068262
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 22 SoC families, 14 builds out of 207

---
For more info write to <info@kernelci.org>
