Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDB16AA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBXPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:35:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgBXPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:35:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so10879586wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cKtQiC2jd1yHgZJ7fPi8wzadBigquuIjK2HJ0Aes9KA=;
        b=ScemivkC9RbWDm/VQ75Iks1Ojdp8A7snVMM+mmpfk0gyHI9NZgvNleLBstjftIk1oI
         /z3GqiH5bcmkuIiurrEujPHemgzjhV0+FCtgqv9aMHIROw4cLmhSzPu1pSYftS2DDE8a
         +VQY0yR36RH4YHBxjfPC638rybmTLNg2aNwUPv1/U7xOKsX4wadp2qKR8IxwJZ3c3FTu
         O3Z0BVxBzCKyg4ee6fTazZKokKLpUEjGU3IT5NrZ2dC7CrPwlyymu1AmC9Rn1Mfq2w6F
         bDDBIhbcgZMD7kfwdZshkiLlx0iVL3KpJ/dD6r9Mck8G6h8Pm+JhYmjTF91Hp9kuSIjG
         +zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cKtQiC2jd1yHgZJ7fPi8wzadBigquuIjK2HJ0Aes9KA=;
        b=bXua0o6tURdiKuRPa8O7sQuCjiBYnMsg5dxZ5gLtE8B4e84RgOrF9JKLKBHWoXjt2n
         Vg/idYflqRdB5+AB4rcjZgzyNwbTjQWopqcVXMAF6m1zuLWo0UxCfEmc929xhn/PSg5O
         BuufWavZUzJ9CFkmvFLptuE27zxOkC69FU/4dZrKjI4NDSuN8w5UCTn8YPBLdWbVRCu8
         D4c2ZxwH3y84FzAOX+9yLVtLxd6XS+5x08/nakkYtWbVJGssvvD/7Af+sMjUoKgQ/phN
         aD6d3gtCAeq4IUSqKkKTwLF/ALbkqkCNNx6a6bIuVW9KTwGdlXeBk76hooV/fGwTkFrV
         xGlg==
X-Gm-Message-State: APjAAAULANOy3iX188TgAaIFi7I90jzouborXdjXqtBNc3iIaogilwey
        lmrPmBKL6VALpq1V58EPtCJWDg==
X-Google-Smtp-Source: APXvYqz2CYfmMRAZAp4q7TrUnRG/LEy/Ye+UkeR9wkGAOqbL5Ct95FcHtF+c0ImPSHec7EKAX+iZRQ==
X-Received: by 2002:adf:a746:: with SMTP id e6mr67033827wrd.329.1582558497396;
        Mon, 24 Feb 2020 07:34:57 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id v5sm19443753wrv.86.2020.02.24.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:34:56 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:34:56 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Colin King <colin.king@canonical.com>
Cc:     mlxsw@mellanox.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/mlxfw: fix spelling mistake: "progamming" ->
 "programming"
Message-ID: <20200224153456.GD16270@nanopsycho>
References: <20200224152101.361648-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224152101.361648-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 24, 2020 at 04:21:01PM CET, colin.king@canonical.com wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>There is a spelling mistake in a literal string. Fix it.
>
>Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
