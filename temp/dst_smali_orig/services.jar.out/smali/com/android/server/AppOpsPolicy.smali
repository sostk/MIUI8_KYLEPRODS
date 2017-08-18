.class public Lcom/android/server/AppOpsPolicy;
.super Ljava/lang/Object;
.source "AppOpsPolicy.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/AppOpsPolicy$PolicyPkg;,
        Lcom/android/server/AppOpsPolicy$PolicyOp;
    }
.end annotation


# static fields
.field public static final CONTROL_NOSHOW:I = 0x1

.field public static final CONTROL_SHOW:I = 0x0

.field public static final CONTROL_UNKNOWN:I = 0x2

.field static final DEBUG:Z = false

.field public static final RATE_LIMIT_OPS_TOTAL_PKG_COUNT:I = 0x4

.field public static final RATE_LIMIT_OP_COUNT:I = 0x3

.field public static final RATE_LIMIT_OP_DELAY_CEILING:I = 0xa

.field static final TAG:Ljava/lang/String; = "AppOpsPolicy"


# instance fields
.field final mContext:Landroid/content/Context;

.field final mFile:Ljava/io/File;

.field mPolicy:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/android/server/AppOpsPolicy$PolicyPkg;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/io/File;Landroid/content/Context;)V
    .locals 1
    .param p1, "file"    # Ljava/io/File;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    iput-object p1, p0, Lcom/android/server/AppOpsPolicy;->mFile:Ljava/io/File;

    iput-object p2, p0, Lcom/android/server/AppOpsPolicy;->mContext:Landroid/content/Context;

    return-void
.end method

.method private getAppType(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .local v1, "appType":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v3, p0, Lcom/android/server/AppOpsPolicy;->mContext:Landroid/content/Context;

    if-eqz v3, :cond_2

    :try_start_0
    iget-object v3, p0, Lcom/android/server/AppOpsPolicy;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, p1, v4}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    :goto_0
    if-eqz v0, :cond_0

    iget v3, v0, Landroid/content/pm/ApplicationInfo;->flags:I

    and-int/lit8 v3, v3, 0x1

    if-eqz v3, :cond_1

    const-string v1, "system-app"

    .end local v1    # "appType":Ljava/lang/String;
    :cond_0
    :goto_1
    return-object v1

    .restart local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .restart local v1    # "appType":Ljava/lang/String;
    :catch_0
    move-exception v2

    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const/4 v0, 0x0

    goto :goto_0

    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v2    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_1
    const-string v1, "user-app"

    .local v1, "appType":Ljava/lang/String;
    goto :goto_1

    .restart local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .local v1, "appType":Ljava/lang/String;
    :cond_2
    const-string v3, "AppOpsPolicy"

    const-string v4, "Context is null"

    invoke-static {v3, v4}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private readApplicationPolicy(Lorg/xmlpull/v1/XmlPullParser;)V
    .locals 7
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;,
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x3

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v0

    .local v0, "outerDepth":I
    :cond_0
    :goto_0
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v2

    .local v2, "type":I
    const/4 v3, 0x1

    if-eq v2, v3, :cond_3

    if-ne v2, v6, :cond_1

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v3

    if-le v3, v0, :cond_3

    :cond_1
    if-eq v2, v6, :cond_0

    const/4 v3, 0x4

    if-eq v2, v3, :cond_0

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v1

    .local v1, "tagName":Ljava/lang/String;
    const-string v3, "pkg"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-direct {p0, p1}, Lcom/android/server/AppOpsPolicy;->readPkgPolicy(Lorg/xmlpull/v1/XmlPullParser;)V

    goto :goto_0

    :cond_2
    const-string v3, "AppOpsPolicy"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unknown element under <application>: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/android/internal/util/XmlUtils;->skipCurrentTag(Lorg/xmlpull/v1/XmlPullParser;)V

    goto :goto_0

    .end local v1    # "tagName":Ljava/lang/String;
    :cond_3
    return-void
.end method

.method private readDefaultPolicy(Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;)V
    .locals 6
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .param p2, "packageName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;,
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x0

    const-string v3, "user-app"

    invoke-virtual {v3, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "system-app"

    invoke-virtual {v3, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    const-string v3, "permission"

    invoke-interface {p1, v4, v3}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/app/AppOpsManager;->stringToMode(Ljava/lang/String;)I

    move-result v0

    .local v0, "mode":I
    const-string v3, "show"

    invoke-interface {p1, v4, v3}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/server/AppOpsPolicy;->stringToControl(Ljava/lang/String;)I

    move-result v2

    .local v2, "show":I
    if-ne v0, v5, :cond_2

    if-ne v2, v5, :cond_2

    return-void

    .end local v0    # "mode":I
    .end local v2    # "show":I
    :cond_1
    return-void

    .restart local v0    # "mode":I
    .restart local v2    # "show":I
    :cond_2
    iget-object v3, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v3, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .local v1, "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-nez v1, :cond_3

    new-instance v1, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .end local v1    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    invoke-direct {v1, p2, v0, v2, p2}, Lcom/android/server/AppOpsPolicy$PolicyPkg;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    .restart local v1    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    iget-object v3, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v3, p2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void

    :cond_3
    const-string v3, "AppOpsPolicy"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Duplicate policy found for package: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " of type: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    iput v0, v1, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    iput v2, v1, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    goto :goto_0
.end method

.method private readOpPolicy(Lorg/xmlpull/v1/XmlPullParser;Lcom/android/server/AppOpsPolicy$PolicyPkg;)V
    .locals 8
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .param p2, "pkg"    # Lcom/android/server/AppOpsPolicy$PolicyPkg;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;,
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x2

    const/4 v6, 0x0

    if-nez p2, :cond_0

    return-void

    :cond_0
    const-string v5, "name"

    invoke-interface {p1, v6, v5}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "opName":Ljava/lang/String;
    if-nez v3, :cond_1

    const-string v5, "AppOpsPolicy"

    const-string v6, "Op name is null"

    invoke-static {v5, v6}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_1
    invoke-static {v3}, Landroid/app/AppOpsManager;->stringOpToOp(Ljava/lang/String;)I

    move-result v0

    .local v0, "code":I
    const/4 v5, -0x1

    if-ne v0, v5, :cond_2

    const-string v5, "AppOpsPolicy"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unknown Op: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_2
    const-string v5, "permission"

    invoke-interface {p1, v6, v5}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Landroid/app/AppOpsManager;->stringToMode(Ljava/lang/String;)I

    move-result v1

    .local v1, "mode":I
    const-string v5, "show"

    invoke-interface {p1, v6, v5}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/server/AppOpsPolicy;->stringToControl(Ljava/lang/String;)I

    move-result v4

    .local v4, "show":I
    if-ne v1, v7, :cond_3

    if-ne v4, v7, :cond_3

    return-void

    :cond_3
    invoke-virtual {p2, v0}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/AppOpsPolicy$PolicyOp;

    .local v2, "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    if-nez v2, :cond_4

    new-instance v2, Lcom/android/server/AppOpsPolicy$PolicyOp;

    .end local v2    # "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    invoke-direct {v2, v0, v1, v4}, Lcom/android/server/AppOpsPolicy$PolicyOp;-><init>(III)V

    .restart local v2    # "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    invoke-virtual {p2, v0, v2}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->put(ILjava/lang/Object;)V

    :goto_0
    return-void

    :cond_4
    const-string v5, "AppOpsPolicy"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Duplicate policy found for package: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p2, Lcom/android/server/AppOpsPolicy$PolicyPkg;->packageName:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " type: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p2, Lcom/android/server/AppOpsPolicy$PolicyPkg;->type:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " op: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->op:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    iput v1, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->mode:I

    iput v4, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->show:I

    goto :goto_0
.end method

.method private readPkgPolicy(Lorg/xmlpull/v1/XmlPullParser;)V
    .locals 13
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;,
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v12, 0x3

    const/4 v10, 0x0

    const-string v9, "name"

    invoke-interface {p1, v10, v9}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "packageName":Ljava/lang/String;
    if-nez v4, :cond_0

    return-void

    :cond_0
    const-string v9, "type"

    invoke-interface {p1, v10, v9}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "appType":Ljava/lang/String;
    if-nez v0, :cond_1

    return-void

    :cond_1
    const-string v9, "permission"

    invoke-interface {p1, v10, v9}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Landroid/app/AppOpsManager;->stringToMode(Ljava/lang/String;)I

    move-result v2

    .local v2, "mode":I
    const-string v9, "show"

    invoke-interface {p1, v10, v9}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/server/AppOpsPolicy;->stringToControl(Ljava/lang/String;)I

    move-result v6

    .local v6, "show":I
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "key":Ljava/lang/String;
    iget-object v9, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v9, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .local v5, "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-nez v5, :cond_4

    new-instance v5, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .end local v5    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    invoke-direct {v5, v4, v2, v6, v0}, Lcom/android/server/AppOpsPolicy$PolicyPkg;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    .restart local v5    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    iget-object v9, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v9, v1, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v3

    .local v3, "outerDepth":I
    :cond_2
    :goto_1
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v8

    .local v8, "type":I
    const/4 v9, 0x1

    if-eq v8, v9, :cond_6

    if-ne v8, v12, :cond_3

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v9

    if-le v9, v3, :cond_6

    :cond_3
    if-eq v8, v12, :cond_2

    const/4 v9, 0x4

    if-eq v8, v9, :cond_2

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v7

    .local v7, "tagName":Ljava/lang/String;
    const-string v9, "op"

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-direct {p0, p1, v5}, Lcom/android/server/AppOpsPolicy;->readOpPolicy(Lorg/xmlpull/v1/XmlPullParser;Lcom/android/server/AppOpsPolicy$PolicyPkg;)V

    goto :goto_1

    .end local v3    # "outerDepth":I
    .end local v7    # "tagName":Ljava/lang/String;
    .end local v8    # "type":I
    :cond_4
    const-string v9, "AppOpsPolicy"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Duplicate policy found for package: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " of type: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    iput v2, v5, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    iput v6, v5, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    goto :goto_0

    .restart local v3    # "outerDepth":I
    .restart local v7    # "tagName":Ljava/lang/String;
    .restart local v8    # "type":I
    :cond_5
    const-string v9, "AppOpsPolicy"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Unknown element under <pkg>: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/android/internal/util/XmlUtils;->skipCurrentTag(Lorg/xmlpull/v1/XmlPullParser;)V

    goto :goto_1

    .end local v7    # "tagName":Ljava/lang/String;
    :cond_6
    return-void
.end method

.method public static stringToControl(Ljava/lang/String;)I
    .locals 1
    .param p0, "show"    # Ljava/lang/String;

    .prologue
    const-string v0, "true"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const-string v0, "false"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x2

    return v0
.end method


# virtual methods
.method debugPoilcy()V
    .locals 6

    .prologue
    iget-object v5, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Lcom/android/server/AppOpsPolicy$PolicyPkg;>;>;"
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .local v2, "key":Ljava/lang/String;
    iget-object v5, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v5, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .local v4, "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-eqz v4, :cond_0

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    invoke-virtual {v4}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->size()I

    move-result v5

    if-ge v0, v5, :cond_0

    invoke-virtual {v4, v0}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->valueAt(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/AppOpsPolicy$PolicyOp;

    .local v3, "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v0    # "i":I
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    .end local v4    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    :cond_1
    return-void
.end method

.method public getDefualtMode(ILjava/lang/String;)I
    .locals 8
    .param p1, "code"    # I
    .param p2, "packageName"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x2

    const/4 v1, 0x2

    .local v1, "mode":I
    iget-object v5, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    if-nez v5, :cond_0

    return v1

    :cond_0
    invoke-direct {p0, p2}, Lcom/android/server/AppOpsPolicy;->getAppType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "type":Ljava/lang/String;
    if-eqz v4, :cond_1

    move-object v0, v4

    .local v0, "key":Ljava/lang/String;
    iget-object v5, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v5, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .local v3, "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-eqz v3, :cond_1

    iget v5, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    if-eq v5, v7, :cond_1

    iget v1, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    .end local v0    # "key":Ljava/lang/String;
    .end local v3    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    :cond_1
    move-object v0, p2

    .restart local v0    # "key":Ljava/lang/String;
    if-eqz v4, :cond_2

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    iget-object v5, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v5, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .restart local v3    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-eqz v3, :cond_4

    iget v5, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    if-eq v5, v7, :cond_3

    iget v1, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->mode:I

    :cond_3
    invoke-virtual {v3, p1}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/AppOpsPolicy$PolicyOp;

    .local v2, "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    if-eqz v2, :cond_4

    iget v5, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->mode:I

    if-eq v5, v7, :cond_4

    iget v1, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->mode:I

    .end local v2    # "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    :cond_4
    return v1
.end method

.method public isControlAllowed(ILjava/lang/String;)Z
    .locals 9
    .param p1, "code"    # I
    .param p2, "packageName"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x2

    const/4 v0, 0x1

    .local v0, "isShow":Z
    const/4 v4, 0x2

    .local v4, "show":I
    iget-object v6, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    if-nez v6, :cond_0

    return v0

    :cond_0
    invoke-direct {p0, p2}, Lcom/android/server/AppOpsPolicy;->getAppType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .local v5, "type":Ljava/lang/String;
    if-eqz v5, :cond_1

    move-object v1, v5

    .local v1, "key":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v6, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .local v3, "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-eqz v3, :cond_1

    iget v6, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    if-eq v6, v8, :cond_1

    iget v4, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    .end local v1    # "key":Ljava/lang/String;
    .end local v3    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    :cond_1
    move-object v1, p2

    .restart local v1    # "key":Ljava/lang/String;
    if-eqz v5, :cond_2

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_2
    iget-object v6, p0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v6, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;

    .restart local v3    # "pkg":Lcom/android/server/AppOpsPolicy$PolicyPkg;
    if-eqz v3, :cond_4

    iget v6, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    if-eq v6, v8, :cond_3

    iget v4, v3, Lcom/android/server/AppOpsPolicy$PolicyPkg;->show:I

    :cond_3
    invoke-virtual {v3, p1}, Lcom/android/server/AppOpsPolicy$PolicyPkg;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/AppOpsPolicy$PolicyOp;

    .local v2, "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    if-eqz v2, :cond_4

    iget v6, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->show:I

    if-eq v6, v8, :cond_4

    iget v4, v2, Lcom/android/server/AppOpsPolicy$PolicyOp;->show:I

    .end local v2    # "op":Lcom/android/server/AppOpsPolicy$PolicyOp;
    :cond_4
    const/4 v6, 0x1

    if-ne v4, v6, :cond_5

    const/4 v0, 0x0

    :cond_5
    return v0
.end method

.method readPolicy()V
    .locals 18

    .prologue
    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/server/AppOpsPolicy;->mFile:Ljava/io/File;

    monitor-enter v15

    :try_start_0
    new-instance v10, Ljava/io/FileInputStream;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mFile:Ljava/io/File;

    invoke-direct {v10, v14}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .local v10, "stream":Ljava/io/FileInputStream;
    const/4 v11, 0x0

    .local v11, "success":Z
    :try_start_1
    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v9

    .local v9, "parser":Lorg/xmlpull/v1/XmlPullParser;
    const/4 v14, 0x0

    invoke-interface {v9, v10, v14}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    const/4 v11, 0x1

    :cond_0
    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v13

    .local v13, "type":I
    const/4 v14, 0x2

    if-eq v13, v14, :cond_1

    const/4 v14, 0x1

    if-ne v13, v14, :cond_0

    :cond_1
    const/4 v14, 0x2

    if-eq v13, v14, :cond_3

    new-instance v14, Ljava/lang/IllegalStateException;

    const-string v16, "no start tag found"

    move-object/from16 v0, v16

    invoke-direct {v14, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v14
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_9
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v13    # "type":I
    :catch_0
    move-exception v3

    .local v3, "e":Ljava/lang/IllegalStateException;
    :try_start_2
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v11, :cond_2

    :try_start_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :cond_2
    :try_start_4
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_d
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .end local v3    # "e":Ljava/lang/IllegalStateException;
    :goto_0
    monitor-exit v15

    return-void

    .end local v10    # "stream":Ljava/io/FileInputStream;
    .end local v11    # "success":Z
    :catch_1
    move-exception v1

    .local v1, "e":Ljava/io/FileNotFoundException;
    :try_start_5
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "App ops policy file ("

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/AppOpsPolicy;->mFile:Ljava/io/File;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v17

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    const-string v17, ") not found; Skipping."

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    monitor-exit v15

    return-void

    .end local v1    # "e":Ljava/io/FileNotFoundException;
    .restart local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v10    # "stream":Ljava/io/FileInputStream;
    .restart local v11    # "success":Z
    .restart local v13    # "type":I
    :cond_3
    :try_start_6
    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v8

    .local v8, "outerDepth":I
    :cond_4
    :goto_1
    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v13

    const/4 v14, 0x1

    if-eq v13, v14, :cond_c

    const/4 v14, 0x3

    if-ne v13, v14, :cond_5

    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v14

    if-le v14, v8, :cond_c

    :cond_5
    const/4 v14, 0x3

    if-eq v13, v14, :cond_4

    const/4 v14, 0x4

    if-eq v13, v14, :cond_4

    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v12

    .local v12, "tagName":Ljava/lang/String;
    const-string v14, "user-app"

    invoke-virtual {v12, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_6

    const-string v14, "system-app"

    invoke-virtual {v12, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_8

    :cond_6
    move-object/from16 v0, p0

    invoke-direct {v0, v9, v12}, Lcom/android/server/AppOpsPolicy;->readDefaultPolicy(Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/IllegalStateException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/lang/NumberFormatException; {:try_start_6 .. :try_end_6} :catch_4
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_6 .. :try_end_6} :catch_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_b
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_6 .. :try_end_6} :catch_9
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_1

    .end local v8    # "outerDepth":I
    .end local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v12    # "tagName":Ljava/lang/String;
    .end local v13    # "type":I
    :catch_2
    move-exception v5

    .local v5, "e":Ljava/lang/NullPointerException;
    :try_start_7
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-nez v11, :cond_7

    :try_start_8
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    :cond_7
    :try_start_9
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    goto/16 :goto_0

    :catch_3
    move-exception v2

    .local v2, "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v5    # "e":Ljava/lang/NullPointerException;
    .restart local v8    # "outerDepth":I
    .restart local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v12    # "tagName":Ljava/lang/String;
    .restart local v13    # "type":I
    :cond_8
    :try_start_a
    const-string v14, "application"

    invoke-virtual {v12, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_a

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/android/server/AppOpsPolicy;->readApplicationPolicy(Lorg/xmlpull/v1/XmlPullParser;)V
    :try_end_a
    .catch Ljava/lang/IllegalStateException; {:try_start_a .. :try_end_a} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_a .. :try_end_a} :catch_2
    .catch Ljava/lang/NumberFormatException; {:try_start_a .. :try_end_a} :catch_4
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_a .. :try_end_a} :catch_6
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_b
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_a .. :try_end_a} :catch_9
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto :goto_1

    .end local v8    # "outerDepth":I
    .end local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v12    # "tagName":Ljava/lang/String;
    .end local v13    # "type":I
    :catch_4
    move-exception v6

    .local v6, "e":Ljava/lang/NumberFormatException;
    :try_start_b
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    if-nez v11, :cond_9

    :try_start_c
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    :cond_9
    :try_start_d
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_5
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    goto/16 :goto_0

    :catch_5
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v6    # "e":Ljava/lang/NumberFormatException;
    .restart local v8    # "outerDepth":I
    .restart local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v12    # "tagName":Ljava/lang/String;
    .restart local v13    # "type":I
    :cond_a
    :try_start_e
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Unknown element under <appops-policy>: "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v17

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v9}, Lcom/android/internal/util/XmlUtils;->skipCurrentTag(Lorg/xmlpull/v1/XmlPullParser;)V
    :try_end_e
    .catch Ljava/lang/IllegalStateException; {:try_start_e .. :try_end_e} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_e .. :try_end_e} :catch_2
    .catch Ljava/lang/NumberFormatException; {:try_start_e .. :try_end_e} :catch_4
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_e .. :try_end_e} :catch_6
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_b
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_e .. :try_end_e} :catch_9
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    goto/16 :goto_1

    .end local v8    # "outerDepth":I
    .end local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v12    # "tagName":Ljava/lang/String;
    .end local v13    # "type":I
    :catch_6
    move-exception v7

    .local v7, "e":Lorg/xmlpull/v1/XmlPullParserException;
    :try_start_f
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    if-nez v11, :cond_b

    :try_start_10
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_1

    :cond_b
    :try_start_11
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_7
    .catchall {:try_start_11 .. :try_end_11} :catchall_1

    goto/16 :goto_0

    :catch_7
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v7    # "e":Lorg/xmlpull/v1/XmlPullParserException;
    .restart local v8    # "outerDepth":I
    .restart local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v13    # "type":I
    :cond_c
    if-nez v11, :cond_d

    :try_start_12
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_1

    :cond_d
    :try_start_13
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_13
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_13} :catch_8
    .catchall {:try_start_13 .. :try_end_13} :catchall_1

    goto/16 :goto_0

    :catch_8
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v8    # "outerDepth":I
    .end local v9    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v13    # "type":I
    :catch_9
    move-exception v4

    .local v4, "e":Ljava/lang/IndexOutOfBoundsException;
    :try_start_14
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_0

    if-nez v11, :cond_e

    :try_start_15
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_1

    :cond_e
    :try_start_16
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_16
    .catch Ljava/io/IOException; {:try_start_16 .. :try_end_16} :catch_a
    .catchall {:try_start_16 .. :try_end_16} :catchall_1

    goto/16 :goto_0

    :catch_a
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v4    # "e":Ljava/lang/IndexOutOfBoundsException;
    :catch_b
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    :try_start_17
    const-string v14, "AppOpsPolicy"

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    const-string v17, "Failed parsing "

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v14, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_0

    if-nez v11, :cond_f

    :try_start_18
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    invoke-virtual {v14}, Ljava/util/HashMap;->clear()V
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_1

    :cond_f
    :try_start_19
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_19
    .catch Ljava/io/IOException; {:try_start_19 .. :try_end_19} :catch_c
    .catchall {:try_start_19 .. :try_end_19} :catchall_1

    goto/16 :goto_0

    :catch_c
    move-exception v2

    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .restart local v3    # "e":Ljava/lang/IllegalStateException;
    :catch_d
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto/16 :goto_0

    .end local v2    # "e":Ljava/io/IOException;
    .end local v3    # "e":Ljava/lang/IllegalStateException;
    :catchall_0
    move-exception v14

    if-nez v11, :cond_10

    :try_start_1a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/AppOpsPolicy;->mPolicy:Ljava/util/HashMap;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Ljava/util/HashMap;->clear()V
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_1

    :cond_10
    :try_start_1b
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V
    :try_end_1b
    .catch Ljava/io/IOException; {:try_start_1b .. :try_end_1b} :catch_e
    .catchall {:try_start_1b .. :try_end_1b} :catchall_1

    :goto_2
    :try_start_1c
    throw v14
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_1

    .end local v10    # "stream":Ljava/io/FileInputStream;
    .end local v11    # "success":Z
    :catchall_1
    move-exception v14

    monitor-exit v15

    throw v14

    .restart local v10    # "stream":Ljava/io/FileInputStream;
    .restart local v11    # "success":Z
    :catch_e
    move-exception v2

    .restart local v2    # "e":Ljava/io/IOException;
    goto :goto_2
.end method
