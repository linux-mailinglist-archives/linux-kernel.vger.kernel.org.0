Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767F9D1BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfJIW0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 18:26:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40323 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfJIW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:26:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so5791807qte.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=CiNtf9aBIrrX5eeY+lWUtp3cirNfSmpXQ9FltiktAv8=;
        b=FifhUGIjpae34or/omxVvVhF4rTt/qglBiIOmZrJKECnjR1gVHZsl8LD6YgHFKTCXk
         hCZnog3cO2un3XkGVataAVPc30evbmMui325U5Rp6eS6XapsDteXGLN6FhKqGctsV2ao
         Mx5Ef0I0DwwIRgRslVWXqZydwnLF4QJibAxyqWnlvJgXenZgySzhiKYKJ2uae0g4NoWq
         alJLKjeJwSPpS3TJfgbwb9lEEdUq51XdBXR6eLtEthEIroRTCUZMZeqzJ967zjwYCcUi
         FBTwZhcbcy1YP3GF59x/oZdm0LstQNmyJKF1+4jueJ4vBmMxQkuLHpXREbEd1e/VGs0B
         wX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=CiNtf9aBIrrX5eeY+lWUtp3cirNfSmpXQ9FltiktAv8=;
        b=dpOp8Evf8isTSLYIRgv1MGskUOdc+bZ+ni+fjWMX7BP/DjT1TUFQcIjg4CM+kAWQBz
         meFJA3uKGimK1bCRIenOWWFj9mNh36XbQnxWYj2jzL2+tdVnwGQ868sywil8UkyEkV7E
         xakX88JNiPZ+YpU/jxmAEsA1jY4ItZqSJHWRdFJsFfsu8BsVScRP9dEEJvGYQQXvYW2m
         dJE+GHMGK0tOBVEvkVCd4j+UmsvZM4DXZBiIDjDxW63HQL+qdO1YNqvlCL0/m7zD6G7J
         sKgLaZBIDFAb22gEJnLAYdREtHg4TuwPhbG3k00xnlV9R98tQ8wr6JrBxeok16WyKJ1Z
         af+w==
X-Gm-Message-State: APjAAAWL5Ok8VRUMm5PiOStOIb2qDUHVfWZQyiw8eGS2rbsuQ/JfCTke
        oiXVQcvYDuhQcWgKDNWSgwK0PA==
X-Google-Smtp-Source: APXvYqy0slX/EioTfIAvk6LMnCaI+bB5mkLKuNgrupgqFoZCuC6hMmDIMoLJbc3HFKkDgCKbzceKzA==
X-Received: by 2002:a05:6214:1264:: with SMTP id r4mr6460857qvv.64.1570659993075;
        Wed, 09 Oct 2019 15:26:33 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k54sm2393829qtf.28.2019.10.09.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 15:26:32 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:26:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: add flexible PPS to dwmac 4.10a
Message-ID: <20191009152618.33b45c2d@cakuba.netronome.com>
In-Reply-To: <20191007154306.95827-5-antonio.borneo@st.com>
References: <20191007154306.95827-1-antonio.borneo@st.com>
        <20191007154306.95827-5-antonio.borneo@st.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 17:43:06 +0200, Antonio Borneo wrote:
> All the registers and the functionalities used in the callback
> dwmac5_flex_pps_config() are common between dwmac 4.10a [1] and
> 5.00a [2].
> 
> Reuse the same callback for dwmac 4.10a too.
> 
> Tested on STM32MP15x, based on dwmac 4.10a.
> 
> [1] DWC Ethernet QoS Databook 4.10a October 2014
> [2] DWC Ethernet QoS Databook 5.00a September 2017
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>

Applied to net-next.
