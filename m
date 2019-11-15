Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BEFDB76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 11:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKOKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 05:35:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36339 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:35:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so1014048lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+PSnzKtja1Ax7hxE68546cbLixgKvyFJbg+bbzyNhg=;
        b=UMHsl8nlmA66VaV3D9wHoJhMCfUadP4SBWVwxFDj5aPll1Sff7hPsLyOB9PDLxedV+
         +bFLeR70XvA14r8cpiwPF3RKDnk1bzILLFVHyx2qEfrn+3LB0DR2Rou4kZVDe0de0xGi
         vlSgH+f7xchJknSannwxUqmxFjPSN8X4qmltznf5JjY52rbHwM2OOWmMzDnNR5i/5ieV
         JdgnUBZYRz1ikHJOM5h1JShNdGUIDGDMkBAR1HyVaemzNbZON5m+q9bh8YhY4ziYI3J6
         QqhB7zw0nxrioPQ94srgpnk69V0cVivjw+8z2p+SsK9KFXjUbws0ff3/VfjOLQ8ideZD
         pPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+PSnzKtja1Ax7hxE68546cbLixgKvyFJbg+bbzyNhg=;
        b=iOcnjTeLqbNHcRiRGTPqnxZ6xuBZhWfGWMtV1I94NWBYNmT7bqHfXsDI4+R0aVeJzi
         +3JMkZnsVP1CPM3DsZI7fTg5al8oJZWmM+55p+SChVhtK2IO5lNanEX9FS14qu+MqIoy
         vTdFEwmnDHN6KYmvlZ7hDXHLPj8BXIV5bT2xANPVMkyPy3UClFvJvtTB+512sozprBLJ
         qR46ksyIIA/8qRIpttqhpAO59WueLTWMxn+UaZ4Sl6gyI9YmuoOyF8xmwdVCwPhD0bWe
         h5mVybqc0VlVckbWRgmto+Ew1oArC47PoChvv3JvDSV3aTjejHLx8XQiQ7bE5dkPNXcc
         ECsw==
X-Gm-Message-State: APjAAAWI2SF1d26t97Oe9lWgf7gNYJUU6ekvt1mSkeRl5gqjljMmrzhV
        0nx+8r/TS6cmlHIDMB2/kPFiTw==
X-Google-Smtp-Source: APXvYqwEI5CQj5B/Fs+4NNeTLFzILE3sMvUJYAv0KLf6gpWqi8RWkC489XyClBBvR4ZjICQXo5NGRw==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr10922147lfn.41.1573814144566;
        Fri, 15 Nov 2019 02:35:44 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id 70sm4317905lfh.86.2019.11.15.02.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 02:35:44 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:35:42 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Volodymyr_Babchuk@epam.com, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, etienne.carriere@linaro.org
Subject: Re: [Patch v2] tee: optee: Fix dynamic shm pool allocations
Message-ID: <20191115103541.GA21189@jax>
References: <1573212434-25526-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1573212434-25526-1-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Fri, Nov 08, 2019 at 04:57:14PM +0530, Sumit Garg wrote:
> In case of dynamic shared memory pool, kernel memory allocated using
> dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
> during optee_open_session() or optee_invoke_func().
> 
> So fix dmabuf_mgr pool allocations via an additional call to
> optee_shm_register().
> 
> Also, allow kernel pages to be registered as shared memory with OP-TEE.
> 
> Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v2:
> Merge the dependency patch: https://lkml.org/lkml/2019/10/31/431
> 

Looks good, I'm picking this up.

Thanks,
Jens
