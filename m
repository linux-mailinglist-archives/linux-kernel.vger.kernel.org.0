Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982271905F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 07:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXGu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 02:50:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39265 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbgCXGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:50:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TtUkIEH_1585032618;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TtUkIEH_1585032618)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Mar 2020 14:50:19 +0800
Subject: Re: [PATCH v4] Translate debugfs.txt into Chinese and link it to the
 index.
To:     Chucheng Luo <luochucheng@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200323085348.15121-1-luochucheng@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ac86742c-8a4c-3afe-e1c1-a35bca4b6c94@linux.alibaba.com>
Date:   Tue, 24 Mar 2020 14:49:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323085348.15121-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Did you use 'git am' try to apply your patch before sent it out?

fatal: cannot convert from y to UTF-8



�� 2020/3/23 ����4:53, Chucheng Luo д��:
> Translate Documentation/filesystems/debugfs.txt into Chinese.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> ---
>  .../zh_CN/filesystems/debugfs.rst             | 253 ++++++++++++++++++
>  .../translations/zh_CN/filesystems/index.rst  |  21 ++
>  Documentation/translations/zh_CN/index.rst    |   2 +
>  3 files changed, 276 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/debugfs.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> new file mode 100644
> index 000000000000..9c7012c4b48a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -0,0 +1,253 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. warning::
> +     ���ļ���Ŀ����Ϊ�����Ķ��߸������Ķ�����⣬��������Ϊһ����֧�� ��ˣ�
> +     ������Դ��ļ����κ��������£����ȳ��Ը���ԭʼӢ���ļ���
> +
> +.. note::
> +     ��������ֱ��ĵ���ԭʼ�ļ����κβ�ͬ�����з������⣬����ϵ���ļ������ߣ�
> +     ���������޳��ɵİ�����<luochucheng@vivo.com>��

We have a  disclaimer-zh_CN.rst, please use it.

> +
> +:Original: :ref:`Documentation/filesystems/debugfs.txt<debugfs_index>`
> +

it's broken, no space between 'debugfs.txt' and <xxx>.


> +==========================
> +Debugfs
> +==========================

too many '=' here.

> +
> +����
> +::
> +
> +	���İ�ά���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ淭���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ�У����:  �޳��� Chucheng Luo <luochucheng@vivo.com>
> +
> +
> +
> +
> +��Ȩ����2020 �޳��� <luochucheng@vivo.com>
> +
> +����
> +====

no introduce in original file, please follow it.

> +
> +Debugfs���ں˿�����Ա���û��ռ��ȡ��Ϣ�ļ򵥷�����
> +��/proc��ͬ��procֻ�ṩ������Ϣ��
> +Ҳ����sysfs,�����ϸ�ġ�ÿ���ļ�һ��ֵ���Ĺ���
> +debugfs����û�й���,������Ա�������������������Ҫ���κ���Ϣ��
> +debugfs�ļ�ϵͳҲ���������ȶ���ABI�ӿڡ�
> +�������Ͻ���debugfs�����ļ���ʱ��û���κ�Լ����
> +����[1]ʵ���������������ô�򵥡�
> +��ʹ��debugfs�ӿڣ�Ҳ��ø�����Ҫ�������,
> +���������ֽӿڲ��䡣

Again 80 chars for one line!

> +
> +�÷�
> +====
> +
> +Debugfsͨ��ʹ���������װ::
> +
> +    mount -t debugfs none /sys/kernel/debug
> +
> +�����Ч��/etc/fstab�У���
> +debugfs��Ŀ¼Ĭ�Ͻ�����root�û����ʡ�
> +Ҫ���Ķ��ļ����ķ��ʣ���ʹ�á� uid������ gid���͡� mode������ѡ�
> +
> +��ע�⣬debugfs API������GPLЭ�鵼����ģ�顣
> +
> +ʹ��debugfs�Ĵ���Ӧ����<linux/debugfs.h>��
> +Ȼ�������Ǵ�������һ��Ŀ¼������һ��debugfs�ļ�::
> +
> +    struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
> +
> +����ɹ����˵��ý���ָ���ĸ�Ŀ¼�´���һ����Ϊname��Ŀ¼��
> +���parent����Ϊ�գ������debugfs��Ŀ¼�д�����
> +����Ŀ¼�ɹ�ʱ������ֵ��һ��ָ��dentry�ṹ���ָ�롣
> +��dentry�ṹ���ָ���������Ŀ¼�д����ļ����Լ����������ɾ�����
> +ERR_PTR��-ERROR������ֵ��������
> +�������ERR_PTR��-ENODEV����������ں�
> +����û��debugfs֧�ֵ�����¹����ģ������������������������á�
> +
> +��debugfsĿ¼�д����ļ�����ͨ�÷�����::
> +
> +    struct dentry *debugfs_create_file(const char *name, umode_t mode,
> +				       struct dentry *parent, void *data,
> +				       const struct file_operations *fops);
> +
> +�����name��Ҫ�������ļ������ƣ�mode�����˷���
> +�ļ�Ӧ���е�Ȩ�ޣ�parentָ��Ӧ�ñ����ļ���Ŀ¼
> +��data���洢�ڲ�����inode�ṹ���i_private�ֶ���
> +����fops��һ���ļ�������������Щ������
> +ʵ���ļ������ľ�����Ϊ�����٣�read������/��write����
> +����Ӧ�ṩ���������Ը�����Ҫ�������ڡ�ͬ���ģ�
> +����ֵ����ָ�򴴽��ļ���dentryָ�룬
> +����ʱ����ERR_PTR��-ERROR����ϵͳ��֧��debugfsʱ����ֵΪERR_PTR��-ENODEV����
> +
> +����һ����ʼ��С���ļ�������ʹ�����º�������::
> +
> +    struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
> +				struct dentry *parent, void *data,
> +				const struct file_operations *fops,
> +				loff_t file_size);
> +
> +file_size�ǳ�ʼ�ļ���С����������������debugfs_create_file����ͬ��
> +
> +���������£�û��Ҫ�Լ�ȥ����һ���ļ�����;
> +����һЩ�򵥵����,debugfs�����ṩ��������������
> +������������ֵ���ļ�����ʹ�������κ�һ���::
> +
> +    void debugfs_create_u8(const char *name, umode_t mode,
> +			   struct dentry *parent, u8 *value);
> +    void debugfs_create_u16(const char *name, umode_t mode,
> +			    struct dentry *parent, u16 *value);
> +    struct dentry *debugfs_create_u32(const char *name, umode_t mode,
> +				      struct dentry *parent, u32 *value);
> +    void debugfs_create_u64(const char *name, umode_t mode,
> +			    struct dentry *parent, u64 *value);
> +
> +��Щ�ļ�֧�ֶ�ȡ��д�����ֵ��
> +���ĳ���ļ���֧��д�룬ֻ�������Ҫ����mode����λ��
> +��Щ�ļ��е�ֵ��ʮ���Ʊ�ʾ�������Ҫʹ��ʮ�����ƣ�
> +����ʹ�����º������::
> +
> +    void debugfs_create_x8(const char *name, umode_t mode,
> +			   struct dentry *parent, u8 *value);
> +    void debugfs_create_x16(const char *name, umode_t mode,
> +			    struct dentry *parent, u16 *value);
> +    void debugfs_create_x32(const char *name, umode_t mode,
> +			    struct dentry *parent, u32 *value);
> +    void debugfs_create_x64(const char *name, umode_t mode,
> +			    struct dentry *parent, u64 *value);
> +
> +��Щ����ֻ���ڿ�����Ա֪������ֵ�Ĵ�С��ʱ������á�
> +ĳЩ���������ڲ�ͬ�ļܹ����в�ͬ�Ŀ�ȣ�������ʹ��������Щ���ӡ�
> +��������������¿���ʹ�����º���::
> +
> +    void debugfs_create_size_t(const char *name, umode_t mode,
> +			       struct dentry *parent, size_t *value);
> +
> +�������ϣ��˺���������һ��debugfs�ļ�����ʾ����Ϊsize_t�ı�����
> +
> +ͬ���أ�Ҳ�е����޷��ų����ͱ����ĺ������ֱ���ʮ���ƺ�ʮ�����Ʊ�ʾ����::
> +
> +    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
> +					struct dentry *parent,
> +					unsigned long *value);
> +    void debugfs_create_xul(const char *name, umode_t mode,
> +			    struct dentry *parent, unsigned long *value);
> +
> +����ֵ����ͨ�����·�ʽ������debugfs��::
> +
> +    struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> +				       struct dentry *parent, bool *value);
> +
> +
> +��ȡ����ļ�������Y�����ڷ���ֵ����N��������з���
> +д���ʱ����ֻ���ܴ�д��Сдֵ��1��0���κ��������뽫�����ԡ�
> +
> +ͬ����atomic_t���͵�ֵҲ���Է�����debugfs��::
> +
> +    void debugfs_create_atomic_t(const char *name, umode_t mode,
> +				 struct dentry *parent, atomic_t *value)
> +
> +��ȡ���ļ������atomic_tֵ��д����ļ�������atomic_tֵ��
> +
> +��һ��ѡ����ͨ�����½ṹ��ͺ�������һ��������������ݿ�::
> +
> +    struct debugfs_blob_wrapper {
> +	void *data;
> +	unsigned long size;
> +    };
> +
> +    struct dentry *debugfs_create_blob(const char *name, umode_t mode,
> +				       struct dentry *parent,
> +				       struct debugfs_blob_wrapper *blob);
> +
> +��ȡ���ļ���������ָ��ָ��debugfs_blob_wrapper�ṹ������ݡ�
> +һЩ����ʹ�á�blobs����Ϊһ�ַ��ؼ��У���̬����ʽ���ı��ļ򵥷�����
> +������������ڵ�����������Ϣ�����ƺ���������û���κδ�����������
> +��ע�⣬ʹ��debugfs_create_blob����������������ļ���ֻ���ġ�
> +
> +�����Ҫת��һ���Ĵ����飨�ڿ��������о�������ô����
> +���������ĵ��Դ�������ϴ��������С�
> +Debugfs�ṩ����������һ�����ڴ������Ĵ����ļ���
> +��һ����һ���Ĵ��������һ��˳���ļ���::
> +
> +    struct debugfs_reg32 {
> +	char *name;
> +	unsigned long offset;
> +    };
> +
> +    struct debugfs_regset32 {
> +	struct debugfs_reg32 *regs;
> +	int nregs;
> +	void __iomem *base;
> +    };
> +
> +    struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
> +				     struct dentry *parent,
> +				     struct debugfs_regset32 *regset);
> +
> +    void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
> +			 int nregs, void __iomem *base, char *prefix);
> +
> +��base����������Ϊ0������������Ҫʹ��__stringify����
> +reg32���飬ʵ���������Ĵ������ƣ��꣩�ǼĴ�������
> +��ַ�ϵ��ֽ�ƫ������
> +
> +���Ҫ��debugfs��ת��u32���飬����ʹ�����º��������ļ�::
> +
> +     void debugfs_create_u32_array(const char *name, umode_t mode,
> +			struct dentry *parent,
> +			u32 *array, u32 elements);
> +
> +��array�������ṩ���ݣ�����elements������Ϊ
> +������Ԫ�ص�������ע�⣺���鴴���������С�޷����ġ�
> +
> +��һ���������������豸��ص�seq_file::
> +
> +   struct dentry *debugfs_create_devm_seqfile(struct device *dev,
> +				const char *name,
> +				struct dentry *parent,
> +				int (*read_fn)(struct seq_file *s,
> +					void *data));
> +
> +��dev�����������debugfs�ļ���ص��豸������
> +��read_fn����һ������ָ�룬��������ڴ�ӡseq_file���ݵ�ʱ�򱻻ص���
> +
> +����һЩ����������Ŀ¼�ĺ���::
> +
> +    struct dentry *debugfs_rename(struct dentry *old_dir,
> +		                  struct dentry *old_dentry,
> +		                  struct dentry *new_dir,
> +				  const char *new_name);
> +
> +    struct dentry *debugfs_create_symlink(const char *name,
> +                                          struct dentry *parent,
> +                                          const char *target);
> +
> +����debugfs_rename()��Ϊ���е�debugfs�ļ���������
> +����ͬʱ�л�Ŀ¼�� new_name��������֮ǰ���ܴ��ڣ�
> +����ֵΪold_dentry�����а������µ���Ϣ��
> +����ʹ��debugfs_create_symlink���������������ӡ�
> +
> +����debugfs�û����뿼�ǵ�һ�����ǣ�
> +debugfs�����Զ���������д������κ�Ŀ¼��
> +���һ��ģ���ڲ���ʽɾ��debugfsĿ¼�������ж��ģ�飬
> +������������ܶ�Ұָ�룬�Ӷ�����ϵͳ���ȶ���
> +��ˣ�����debugfs�û�-��������Щ������Ϊģ�鹹�����û�-����
> +��ģ��unload��ʱ��׼��ɾ���ڴ˴����������ļ���Ŀ¼��
> +һ���ļ�����ͨ�����·�ʽɾ��::
> +
> +    void debugfs_remove(struct dentry *dentry);
> +
> +dentryֵ����ΪNULL�����ֵ������������£��������κ��ļ���ɾ����
> +
> +�ܾ���ǰ���ں˿�����ʹ��debugfsʱ��Ҫ��¼
> +���Ǵ�����ÿ��dentryָ�룬�Ա���������ļ������Ա��������
> +���ǣ�����debugfs�û��ܵ������º����ݹ����֮ǰ�������ļ�::
> +
> +    void debugfs_remove_recursive(struct dentry *dentry);
> +
> +�������Ӧ����Ŀ¼��dentry���ݸ����Ϻ�����
> +���Ŀ¼�µ�������νṹ���ᱻɾ����
> +
> +ע�⣺

no 'attention' in original file.

> +[1] http://lwn.net/Articles/309298/
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> new file mode 100644
> index 000000000000..3a7f5233767d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +Linux �ں��е��ļ�ϵͳ
> +===============================
> +
> +�����������ָ����ĳһ�콫���ṩ����Linux �����ļ�ϵͳ(VFS)����ι�����
> +������Ϣ���Լ�VFS���µĵ��ļ�ϵͳ��ĿǰΪֹ�������ṩ��������Ϣ��
> +
> +
> +
> +
> +�ļ�ϵͳ
> +===========
> +
> +�����ļ�ϵͳʵ�ֵ��ĵ�.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   debugfs
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index d3165535ec9e..770f886d081c 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -1,3 +1,4 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  .. raw:: latex
>  
>  	\renewcommand\thesection*
> @@ -14,6 +15,7 @@
>     :maxdepth: 2
>  
>     process/index
> +   filesystems/index
>  
>  Ŀ¼�ͱ��
>  ----------
> 
